//
//  Park.swift
//  OutdoorSpaces
//
//  Created by Cynthia Hom on 9/15/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Park: NSObject, MKAnnotation {
    // MARK: Properties
    
    // general stuff
    let title: String?
    var photo: UIImage?
    var restrooms: Bool
    var dogFriendly: Bool
    let coordinate: CLLocationCoordinate2D
    
    //sports courts
    var tennisCourtNum: Int
    var basketballCourtNum: Int
    var soccerFieldNum: Int
    var pickleballNum: Int
    var volleyballCourtNum: Int
    var track: Bool
    var footballFieldNum: Int
    var baseballFieldNum: Int
    var swimmingPool: Bool
    
    // playground
    var sandbox: Bool
    var tanbark: Bool
    var rubber: Bool
    var swingsNum: Int
    var seesawNum: Int
    
    //seating/bbq/misc stuff
    var seatingArea: Bool
    var bbq: Bool
    var pavedPathways: Bool
    var lighted: Bool
    
    ///__________________________________rating: safety, cleanliness, amenities, overall

    // initializer with everything
    init(title: String, coordinate: CLLocationCoordinate2D, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, tennisCourtNum: Int, basketballCourtNum: Int, soccerFieldNum: Int, pickleballNum: Int, volleyballCourtNum: Int, track: Bool, footballFieldNum: Int, baseballFieldNum: Int, swimmingPool: Bool, sandbox: Bool, tanbark: Bool, rubber: Bool, swingsNum: Int, seesawNum: Int, seatingArea: Bool, bbq: Bool, pavedPathways: Bool, lighted: Bool)
    {
        self.title = title
        self.coordinate = coordinate
        self.photo = photo
        self.restrooms = restrooms
        self.dogFriendly = dogFriendly
        
        // sports courts
        self.tennisCourtNum = tennisCourtNum
        self.basketballCourtNum = basketballCourtNum
        self.soccerFieldNum = soccerFieldNum
        self.pickleballNum = pickleballNum
        self.volleyballCourtNum = volleyballCourtNum
        self.track = track
        self.footballFieldNum = footballFieldNum
        self.baseballFieldNum = baseballFieldNum
        self.swimmingPool = swimmingPool
        
        // playground stuff
        self.sandbox = sandbox
        self.tanbark = tanbark
        self.rubber = rubber
        self.swingsNum = swingsNum
        self.seesawNum = seesawNum
        
        // misc.
        self.seatingArea = seatingArea
        self.bbq = bbq
        self.pavedPathways = pavedPathways
        self.lighted = lighted
        
        super.init()
    }
    
    // initializer with only sports courts
    init(title: String, coordinate: CLLocationCoordinate2D, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, tennisCourtNum: Int, basketballCourtNum: Int, soccerFieldNum: Int, pickleballNum: Int, volleyballCourtNum: Int, track: Bool, footballFieldNum: Int, baseballFieldNum: Int, swimmingPool: Bool)
    {
        self.title = title
        self.photo = photo
        self.coordinate = coordinate
        self.restrooms = restrooms
        self.dogFriendly = dogFriendly
        
        // sports courts
        self.tennisCourtNum = tennisCourtNum
        self.basketballCourtNum = basketballCourtNum
        self.soccerFieldNum = soccerFieldNum
        self.pickleballNum = pickleballNum
        self.volleyballCourtNum = volleyballCourtNum
        self.track = track
        self.footballFieldNum = footballFieldNum
        self.baseballFieldNum = baseballFieldNum
        self.swimmingPool = swimmingPool
        
        // playground stuff
        self.sandbox = false
        self.tanbark = false
        self.rubber = false
        self.swingsNum = 0
        self.seesawNum = 0
        
        // misc.
        self.seatingArea = false
        self.bbq = false
        self.pavedPathways = false
        self.lighted = false
        
        super.init()
    }
    
    // initializer with only playground stuff
    init(title: String, coordinate: CLLocationCoordinate2D, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, sandbox: Bool, tanbark: Bool, rubber: Bool, swingsNum: Int, seesawNum: Int)
    {
        self.title = title
        self.coordinate = coordinate
        self.photo = photo
        self.restrooms = restrooms
        self.dogFriendly = dogFriendly
        
        // playground stuff
        self.sandbox = sandbox
        self.tanbark = tanbark
        self.rubber = rubber
        self.swingsNum = swingsNum
        self.seesawNum = seesawNum
        
        // sports courts
        self.tennisCourtNum = 0
        self.basketballCourtNum = 0
        self.soccerFieldNum = 0
        self.pickleballNum = 0
        self.volleyballCourtNum = 0
        self.track = false
        self.footballFieldNum = 0
        self.baseballFieldNum = 0
        self.swimmingPool = false
        
        // misc.
        self.seatingArea = false
        self.bbq = false
        self.pavedPathways = false
        self.lighted = false
        
        super.init()
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
        
        self.photo = UIImage(named: "logoDark")
        self.restrooms = false
        self.dogFriendly = false
        
        // sports courts
        self.tennisCourtNum = 0
        self.basketballCourtNum = 0
        self.soccerFieldNum = 0
        self.pickleballNum = 0
        self.volleyballCourtNum = 0
        self.track = false
        self.footballFieldNum = 0
        self.baseballFieldNum = 0
        self.swimmingPool = false
        
        // playground stuff
        self.sandbox = false
        self.tanbark = false
        self.rubber = false
        self.swingsNum = 0
        self.seesawNum = 0
        
        // misc.
        self.seatingArea = false
        self.bbq = false
        self.pavedPathways = false
        self.lighted = false
    }
    
    
    // function that takes a given park (with a location) and calculates the distance between the user's location and the park
    func calcDistanceFromLoc(userLoc: CLLocation) -> Double
    {
        let METERS_PER_MILE = 1609.344
        
        
        let parkCoordinate = self.coordinate
        
        // create location from the coordinate
        let parkLocation = CLLocation(latitude: parkCoordinate.latitude, longitude: parkCoordinate.longitude)
        print("inside calc method, park location is \(parkLocation)")
        // calc distance in meters
        let distanceFromLocInMeters = userLoc.distance(from: parkLocation)
        
        // return the disntance from the current location in miles
        return (distanceFromLocInMeters)/(METERS_PER_MILE)
    }
    
    // create a location object with all other vars set as defaults
    /*   init(title: String, coordinate: CLLocationCoordinate2D){
     
     self.title = title
     self.coordinate = coordinate
     
     /*self.locationtitle = locationtitle
     self.discipline = discipline*/
     
     super.init()
     print("Inside init in ParkAnnotation")
     } */
}
