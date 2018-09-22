//
//  ParkAnnotation.swift
//  OutdoorSpaces
// Class to hold information to make a pin on the map with the Park info
// Needs to still be integrated with the Park class data (somehow link the two in the init or soemthing)
//
//  Created by Cynthia Hom on 9/22/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

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
    
    // subtitle displayed when user taps a pin- done this way to comform to the MKAnotation protocal
 /*   var subtitle: String?{
        return locationName
    }*/
}
