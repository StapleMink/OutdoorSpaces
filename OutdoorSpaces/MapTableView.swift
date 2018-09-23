//
//  MapTableView.swift
//  OutdoorSpaces
//
//  Created by Cynthia Hom on 9/23/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class MapTableView: UITableView, UITableViewDataSource {

    // info for the table view
    var parkResults = [Park]()
    
    
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

}
