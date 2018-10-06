//
//  MapViewController.swift
//  OutdoorSpaces

// todo: set up json file with map, do table stuff, organize into extensions
// make search bar cover more when it is clicked on

//  Created by Daniel Budziwojski on 9/14/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var mapView: MKMapView!
    var manager: CLLocationManager?
    

    // location manager stuff
    let locationManager = CLLocationManager()
    // users location upon opening the map
    var userLocation = CLLocation(latitude: 37.787, longitude: -122.408)
    
    //search bar stuff
    @IBOutlet weak var searchbar: UISearchBar!
   // let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: MapTableView!
    
    // constraint outlets to allow table to scroll up
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapViewHeight: NSLayoutConstraint!

    
    
    // info for the pins
    var parksInArea: [Park] = []
    
    // mapview stuff
    @IBOutlet weak var mapView: MKMapView!
    //radius of region displayed by map
    let regionRadius: CLLocationDistance = 2000 // about half a mile
    
    
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
        tableView.dataSource = tableView
        
        // location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // location permission dialog
        locationManager.requestLocation()
        // default location is cupertino apple headquarters
        //userLocation = CLLocation(latitude: 37.787, longitude: -122.408)
        
        //set beginning coordinate and region- later change to user's current location
            // lines moved to the location extension
    //    let initialLocation = userLocation
    //    centerMapOnLocation(location: initialLocation)
        
        // plot all parks in json file
        loadInitialData()
        mapView.addAnnotations(parksInArea)
        
        // put parks within a 10 mile radius in the table view
        tableView.loadInitialParks(allParks: parksInArea)
       // print("finished with viewDidLoad in MapViewController")
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Map Implementation
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            print("location:: (location)")
        }
        
    }

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
    
    //called whenever search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // expand table view to hide part of map
        mapViewHeight.constant = view.frame.height/100
        mapView.updateConstraints()
        
        //search database for the park using contents of search bar
        
        // update table view with results
        
        //testing:
        print("search bar clicked!")
        print("text is " + searchbar.text!)
    }
}


// extension to handle user's location
extension MapViewController: CLLocationManagerDelegate {
    
    // called when user responds to permission dialogue
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        print("inside didChangeAuthorizationstatus" )
    }
    
    // called when the location information comes back
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
            let initialLocation = userLocation
            centerMapOnLocation(location: initialLocation)
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

