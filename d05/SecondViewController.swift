//
//  SecondViewController.swift
//  d05
//
//  Created by Teo FLEMING on 4/10/17.
//  Copyright © 2017 Teo Fleming. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return LocationData.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        
        let info = LocationData.places[cellForRowAt.row]
        cell?.textLabel?.text = info.0
        cell?.detailTextLabel?.text = info.1
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let firstVC = self.tabBarController?.viewControllers?[0] as? FirstViewController {
            firstVC.centerOnSwitch = LocationData.places[indexPath.row].2
        }
        
        self.tabBarController?.selectedIndex = 0
    }
}

