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
    
    // allow table view cells to be reused and dequeued using cell identifier
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ParkMapTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ParkMapTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ParkMapTableViewCell.")
        }
        
        if cell.parkLabel == nil{
            print("cell park label is nil")
        }
        
        // Gets the right park to display
        let parkToDisplay = parkResults[indexPath.row]
        
        // display the park image
        cell.parkImageView.image = parkToDisplay.photo
        
        // only set the cell's label to the park name if the park name exists,
            // otherwise set it to the default name "Park"
        if parkToDisplay.title != nil{
            cell.parkLabel.text = parkToDisplay.title
        }
        else{
            cell.parkLabel.text = "Park"
        }
        //change image later
        
        // _____  maybe rating and stuff later
        
        return cell
    }
    
    // takes in all parks within a 10 mile radius ordered by location
        // (this work is done in the MapViewController
    func loadInitialParks(orderedParks: [Park])
    {
        parkResults = orderedParks
    }
    
    // setter method for parkResults
    func setParkResults(results: [Park])
    {
        parkResults = results
    }


}
