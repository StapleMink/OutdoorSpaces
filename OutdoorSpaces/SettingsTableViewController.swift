//
//  SettingsTableViewController.swift
//  OutdoorSpaces
//
//  Created by Daniel Budziwojski on 10/3/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //MARK: Properties
    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        let build = Bundle.main.infoDictionary!["CFBundleVersion"]!
        self.versionLabel.text = String(describing: version) + " (\(String(describing: build)))"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
