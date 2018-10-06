//
//  MapViewController.swift
//  OutdoorSpaces

// todo:
// make search bar cover more when it is clicked on
// MKCLUSTER ANNOTATION

// click on table view cell should make location detail view controller come up
// questions: clicking on the point on the map should do what?
// figure out location error

//  Created by Daniel Budziwojski and Cynthia Hom on 9/14/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    
    //MARK: Properties
    var manager: CLLocationManager?
    

    // location manager stuff
    let locationManager = CLLocationManager()
    // users location upon opening the map: default is apple
    var userLocation = CLLocation(latitude: 37.331705, longitude: -122.030237)
    var searchActive: Bool = false // whether to display filtereds or location based results
    
    //search bar stuff
    @IBOutlet weak var searchbar: UISearchBar!
   // let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: MapTableView!
    
    // constraint outlets to allow table to scroll up
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapViewHeight: NSLayoutConstraint!

    
    
    // all parks in data:
    var parksInArea: [Park] = []
    // ordered info for pins (in order of distance)
    var orderedParksInArea: [Park] = []
    // filtered parks for table view
  //  var filteredParks: [Park] = []
    
    // mapview stuff
    @IBOutlet weak var mapView: MKMapView!
    //radius of region displayed by map
    let regionRadius: CLLocationDistance = 40000 // about 1 mile
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        // Setup the Search Controller
        /*
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Parks"
        navigationItem.searchController = searchController
        definesPresentationContext = true */
        
        // set up delegates/data sources--extended in the extensions below
        mapView.delegate = self
        searchbar.delegate = self
        searchbar.showsCancelButton = true
        tableView.dataSource = tableView
        
        // location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // location permission dialog
       // locationManager.requestLocation()
        // default location is cupertino apple headquarters
        //userLocation = CLLocation(latitude: 37.331705, longitude: -122.030237)
        
        //set beginning coordinate and region- later change to user's current location
            // lines moved to the location extension
        let initialLocation = userLocation
        centerMapOnLocation(location: initialLocation)
        
        // get all parks in json file
        loadInitialData()

        // order parks by proximity to the user's current location
        orderParksByLoc()
        
        // add these parks to the map and table view
        mapView.addAnnotations(orderedParksInArea)
        tableView.loadInitialParks(orderedParks: orderedParksInArea)

        print("finished with viewDidLoad in MapViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Transparent navigation bar
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: Map View methods
    
    //helper method to set up the map view-- center it on a particular region
    //location: CLLocation is the center point
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        //tell mapView to display the region
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // get the data from the json file with the parks
    func loadInitialData(){
        
        //read info from json file
        guard let fileName = Bundle.main.path(forResource: "PublicParks", ofType: "json")
            else {
                return
        }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            //use JSONSerialization to obtain a JSON object
            let json = try? JSONSerialization.jsonObject(with: data),
            //check that JSON object is a dictionary with String keys and Any values
            let dictionary = json as? [String: Any],
            let parksInFile = dictionary["data"] as? [[Any]]
            else{
                return
        }
        
        // put info into the artworks array
        let validParksInFile = parksInFile.compactMap{
            Park(json: $0)
        }
        parksInArea.append(contentsOf: validParksInFile)
    }

    
    // Takes the Parks array and takes out any parks not within a 3 mile radius of the current location while sorting based on proximity to current user location
    func orderParksByLoc() {

        // loop through array
        for i in 0...parksInArea.count - 1 {
            let park = parksInArea[i]
            
            // for each park, calculate location
            let distanceFromLocInMiles = park.calcDistanceFromLoc(userLoc: userLocation)
            
            // if less than 7 miles from current location,
            // add to array, otherwise do not add to array
            if (distanceFromLocInMiles < 10)
            {
                // add park to array in correct order
                addParkToOrderedArray(park: park, distance: distanceFromLocInMiles)
            }
        }
    }
    
    // uses insertion sort to sort the parks while inserting them into the array
    func addParkToOrderedArray(park: Park, distance: Double)
    {
        // if empty array just add it
        if (orderedParksInArea.count == 0)
        {
            orderedParksInArea.append(park);
        }
        
        // adding to array--go through array until we find that the next park is farther from current location than this park
        var i = 0;
        while (i < orderedParksInArea.count)
        {
            // calc distance of this next park
            let nextParkDist = orderedParksInArea[i].calcDistanceFromLoc(userLoc: userLocation)
            
            // if the next park has a distance farther than this park's distance, add the park here. Otherwise, keep incrementing
            if (nextParkDist < distance) {
                i += 1
            } else{
                // insert this park right before if the next one has a larger distance
                orderedParksInArea.insert(park, at: i)
                
                // quit out of loop
                i = orderedParksInArea.count
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}


// use to handle map view delegate methods
extension MapViewController: MKMapViewDelegate {

    // gets called for every annotation you add to the map (like tableView (_:cellForRowAt:) for table views, returns the view for each annotation
    // tapping the marker gives a callout bubble with a way to get more information about the park/connect to map app, etc.
    func mapView(_ mapView: MKMapView, viewFor
        annotation: MKAnnotation) -> MKAnnotationView?
    {
        //make sure that this annotation is an Artwork object
        guard let annotation = annotation as? Park else{ return nil }
        
        // make them appear as markers/pins
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        // see if there's a reusable annotation view to be used
        if let deqeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            deqeuedView.annotation = annotation
            view = deqeuedView
        }
        else
        {
            // create a new annotation view object
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
}

// extension to handle search bar stuff
extension MapViewController: UISearchBarDelegate {
    // MARK: UISearchBarDelegate
    
    // update table view whenever search bar is editied
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredParks = [Park]()
        //print("text did change called, text is \(searchText)")
        
        // only keep parks that contain the search query
        filteredParks = parksInArea.filter{$0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        self.tableView.setParkResults(results: filteredParks)
        
        // if no parks match query, make array empty
        if(filteredParks.count == 0){
            searchActive = false;
            //self.tableView.setParkResults(results: orderedParksInArea)
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.tableView.setParkResults(results: orderedParksInArea)
        self.tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    //called whenever search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    // search through the database and find parks that match the search query
/*    func findMatchingParks(searchQuery: String) -> [Park]{
        var matchingParks: [Park] = []
        
        // loop through array
        for i in 0...parksInArea.count - 1 {
            let park = parksInArea[i]
            
        }
        
        return matchingParks
    }*/
}


// extension to handle user's location
extension MapViewController: CLLocationManagerDelegate {
    
    // called when user responds to permission dialogue
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        print("inside didChangeAuthorizationstatus, status is \(status)" )
    }
    
    // called when the location information comes back
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("inside location manager 2")
        // first location in array is the user's location
        if let location = locations.first {
            print("location:: \(location)")
            
            // update current location-- simulated location using CupertinoLocation gpx file is
                // Apple Campus, so it should center on Apple Campus
            userLocation = location
            centerMapOnLocation(location: userLocation)
        }
        else
        {
            //let initialLocation = userLocation
            centerMapOnLocation(location: userLocation)
        }
    }
    
    // called if there's an error with the location manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}



// extension to handle TableViewDataSource stuff (commented bc this is now in the MapTableView
/*extension MapViewController: UITableViewDataSource {
 
 //MARK: UITableViewDataSource
 func numberOfSections(in tableView: UITableView) -> Int {
 return 1
 }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //number of parks
 return parkResults.count;
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 } */

