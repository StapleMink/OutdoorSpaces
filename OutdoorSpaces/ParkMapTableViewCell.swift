//
//  ParkMapTableViewCell.swift
//  OutdoorSpaces
//
//  Created by Cynthia Hom on 9/22/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class ParkMapTableViewCell: UITableViewCell {


    // MARK: Properties
    @IBOutlet weak internal var parkLabel: UILabel!
    @IBOutlet weak internal var parkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
