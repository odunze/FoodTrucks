//
//  ListViewController.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    private let viewmodel = MapAndListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Food Trucks"
        
        let mapButton = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(showMap))
        
        navigationItem.rightBarButtonItem = mapButton
        
        tableView.register(TruckCell.self, forCellReuseIdentifier: "truckCell")
        
        viewmodel.fetchFoodTrucks { trucks in
            if let allTrucks = trucks {
                
                self.viewmodel.trucks = allTrucks
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.openTrucks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TruckCell
        
        let truck = viewmodel.openTrucks[indexPath.row]
                
        cell.nameLabel.text = truck.applicant
        cell.addressLabel.text = truck.location
        cell.menuLabel.text = truck.optionaltext
        cell.timeLabel.text = "\(truck.starttime) - \(truck.endtime)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nav = navigationController {
            let selectedTruck = viewmodel.openTrucks[indexPath.row]
            viewmodel.detailedTruck = selectedTruck
            let mapVC = MapViewController()
            mapVC.viewmodel = viewmodel
            nav.present(mapVC, animated: true)
        }
    }
    
    @objc func showMap() {
        if let nav = navigationController {
            let mapVC = MapViewController()
            mapVC.viewmodel = viewmodel
            nav.present(mapVC, animated: true)
        }
    }
}
