//
//  LocationDetailViewController.swift
//  OutdoorSpaces
//
//  Created by Daniel Budziwojski on 9/11/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var saveIcon: UIBarButtonItem!
    
    var isSaved: Bool = false;
    
    
    @IBAction func userSaved(_ sender: Any) {
        if(isSaved) {
            saveIcon.image = UIImage(named: "favoritesIconUnselected")
        } else {
            saveIcon.image = UIImage(named: "favoritesIconSelected")
        }
        isSaved = !isSaved
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
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
