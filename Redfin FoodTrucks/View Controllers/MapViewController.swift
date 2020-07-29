//
//  MapViewController.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var viewmodel: MapAndListViewModel?
    
    private var navbar: UINavigationBar = UINavigationBar()
    private var detailView: TruckDetailView = TruckDetailView(frame: .zero)
    
    private var map: MKMapView = {
        let view = MKMapView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.addressLabel.text = "No truck selected."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let vm = viewmodel {
            
            if vm.detailedTruck == nil {
                for truck in vm.openTrucks {
                    if let coord = truck.coordinates {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coord
                        map.addAnnotation(annotation)
                    }
                }
                map.showAnnotations(map.annotations, animated: true)
            } else if let detailedTruck = vm.detailedTruck {
                showTruckDetail(truck: detailedTruck)
                map.showAnnotations(map.annotations, animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let vm = viewmodel {
            vm.detailedTruck = nil
        }
    }
    
    func showTruckDetail(truck: Truck) {
        
        if let coordinates = truck.coordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            map.addAnnotation(annotation)
        }
        
        updateSelectedTruck(name: truck.applicant, address: truck.location, menu: truck.optionaltext, opening: truck.starttime, closing: truck.endtime)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        modalPresentationStyle = .fullScreen
        
        map.delegate = self
        
        configureNavbar()
        
        view.addSubview(navbar)
        view.addSubview(detailView)
        view.addSubview(map)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavbar() {
        navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        
        let listButton = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(showList))
        
        let navigationItem = UINavigationItem(title: "Food Trucks")
        navigationItem.rightBarButtonItem = listButton
        
        navbar.pushItem(navigationItem, animated: true)
    }
    
    private func updateSelectedTruck(name: String, address: String, menu: String?, opening: String, closing: String) {
        detailView.nameLabel.text = name
        detailView.addressLabel.text = address
        detailView.menuLabel.text = menu
        detailView.timeLabel.text = "\(opening) - \(closing)"
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation else {
            fatalError("Expected Map Annotation")
        }
        
        let index = (map.annotations as NSArray).index(of: annotation)
        
        if let selectedTruck = viewmodel?.openTrucks[index] {
            updateSelectedTruck(name: selectedTruck.applicant, address: selectedTruck.location, menu: selectedTruck.optionaltext, opening: selectedTruck.starttime, closing: selectedTruck.endtime)
        }
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.heightAnchor.constraint(lessThanOrEqualToConstant: 140),
            
            map.topAnchor.constraint(equalTo: navbar.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: detailView.topAnchor)
        ])
    }
    
    @objc func showList() {
        dismiss(animated: true)
    }
}
