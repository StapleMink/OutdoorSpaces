//
//  Park.swift
//  OutdoorSpaces
//
//  Created by Cynthia Hom on 9/15/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import Foundation
import UIKit

class Park {
    // MARK: Properties
    
    // general stuff
    var name: String
    var photo: UIImage?
    var restrooms: Bool
    var dogFriendly: Bool
    
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
    init(name: String, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, tennisCourtNum: Int, basketballCourtNum: Int, soccerFieldNum: Int, pickleballNum: Int, volleyballCourtNum: Int, track: Bool, footballFieldNum: Int, baseballFieldNum: Int, swimmingPool: Bool, sandbox: Bool, tanbark: Bool, rubber: Bool, swingsNum: Int, seesawNum: Int, seatingArea: Bool, bbq: Bool, pavedPathways: Bool, lighted: Bool)
    {
        self.name = name
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
    }
    
    // initializer with only sports courts
    init(name: String, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, tennisCourtNum: Int, basketballCourtNum: Int, soccerFieldNum: Int, pickleballNum: Int, volleyballCourtNum: Int, track: Bool, footballFieldNum: Int, baseballFieldNum: Int, swimmingPool: Bool)
    {
        self.name = name
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
    
    // initializer with only playground stuff
    init(name: String, photo: UIImage?, restrooms: Bool, dogFriendly: Bool, sandbox: Bool, tanbark: Bool, rubber: Bool, swingsNum: Int, seesawNum: Int)
    {
        self.name = name
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
    }

}
