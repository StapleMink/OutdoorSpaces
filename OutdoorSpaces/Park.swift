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
    
    var name: String
    var photo: UIImage?
    //....etc. for rest of amenities
    
    init(name: String, photo: UIImage?)
    {
        self.name = name
        self.photo = photo
        // etc........
    }
}
