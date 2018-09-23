//
//  ParkAnnotation.swift
//  OutdoorSpaces
// Class to hold information to make a pin on the map with the Park info
// NO LONGER USED-- all of this is in the Park.swift file instead
//
//  Created by Cynthia Hom on 9/22/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//
/*
import Foundation
import MapKit

// adopt MKAnnotation protocal by extending NSObject (MKAnnotation is an NSObject Protocol)
class ParkAnnotation: NSObject, MKAnnotation {
    
    // title displayed when user taps a pin
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
   /* let locationName: String
    let discipline: String*/
    
    // create a location object
    init(title: String, coordinate: CLLocationCoordinate2D){
        
        self.title = title
        self.coordinate = coordinate
        
        /*self.locationName = locationName
         self.discipline = discipline*/
        
        super.init()
        print("Inside init in ParkAnnotation")
    }
    
    
    
    // initializer to initialize Park Annotation objects from the json file
    // initializer to get info from the json file
    init?(json: [Any]){
        // get the info using the indicies of the arrays where the stuff is in the json file
        self.title = json[10] as? String ?? "No Title"
        
        // get latitude and longitude if available, otherwise init to empty coordinate
        if let latitude = Double(json[18] as! String), let longitude = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else{
            self.coordinate = CLLocationCoordinate2D()
        }
    }

    
    // subtitle displayed when user taps a pin- done this way to comform to the MKAnotation protocal
 /*   var subtitle: String?{
        return locationName
    }*/
}*/
