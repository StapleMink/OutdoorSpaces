//
//  MapViewController.swift
//  OutdoorSpaces
//
//  Created by Daniel Budziwojski on 9/14/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    //search bar stuff
    @IBOutlet weak var searchbar: UISearchBar!
   // let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    var parkResults = [Park]()
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
