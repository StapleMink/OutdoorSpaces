//
//  MapViewController.swift
//  OutdoorSpaces

// todo: set up json file with map, do table stuff, organize into extensions
//
//  Created by Daniel Budziwojski on 9/14/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    //search bar stuff
    @IBOutlet weak var searchbar: UISearchBar!
   // let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    // info for the table view
    var parkResults = [Park]()
    
    // info for the pins
    var parkAnnotations: [ParkAnnotation] = []
    
    // mapview stuff
    @IBOutlet weak var mapView: MKMapView!
    //radius of region displayed by map
    let regionRadius: CLLocationDistance = 2000 // about half a mile
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        // set up search bar
        searchbar.delegate = self
        // Setup the Search Controller
        /*
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Parks"
        navigationItem.searchController = searchController
        definesPresentationContext = true */
        
        // set up table view
        tableView.dataSource = self
        
        // set up delegates
        mapView.delegate = self
        
        //set beginning coordinate and region- later change to user's current location
        let initialLocation = CLLocation(latitude: 37.3184, longitude: -122.0699)
        centerMapOnLocatwion(location: initialLocation)
        
        // testing: show one pin on the map
    /*    let montavistapark = ParkAnnotation(title: "Monta Vista Park", coordinate: CLLocationCoordinate2D(latitude: 37.3184, longitude: -122.0699))
        mapView.addAnnotation(montavistapark)*/
        
        // plot all parks in json file
        loadInitialData()
        mapView.addAnnotations(parkAnnotations)
        
       // print("finished with viewDidLoad in MapViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Transparent navigation bar
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
    
    // MARK: UISearchBarDelegate
    
    //called whenever search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //search database for the park using contents of search bar
        
        // update table view with results
        
        //testing:
        print("search bar clicked!")
        print("text is " + searchbar.text!)
    }
    
    
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
    
    
    //Map View methods
    
    //helper method to set up the map view-- center it on a particular region
    //location: CLLocation is the center point
    func centerMapOnLocatwion(location: CLLocation)
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
            ParkAnnotation(json: $0)
        }
        parkAnnotations.append(contentsOf: validParksInFile)
        print("loadInitialData completed, parkAnnotations array is \(parkAnnotations)")
        print("coordinate of \(parkAnnotations[0].title) is \(parkAnnotations[0].coordinate)")
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
        guard let annotation = annotation as? ParkAnnotation else{ return nil }
        
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




