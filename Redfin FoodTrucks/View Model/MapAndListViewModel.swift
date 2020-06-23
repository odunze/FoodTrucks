//
//  MapAndListViewModel.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import Foundation

class MapAndListViewModel {
    
    var openTrucks: [Truck] = []
    
    var trucks: [Truck]? {
        didSet {
            if let alltrucks = trucks {

                let opentrucks = alltrucks.filter { isTruckOpen(open: $0.opens, close: $0.closes, on: $0.dayofweekstr)}
                openTrucks = opentrucks
            }
        }
    }
    
    private func isTruckOpen(open: Date?, close: Date?, on day: String?) -> Bool {
        guard let open = open, let close = close, let day = day else {
            return false
        }
        
        let dateFormatter = DateFormatter()
        let currentTime = Date()
        let currentDay = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: currentTime) - 1]
        
           return currentTime >= open && currentTime <= close && day == currentDay ? true : false
       }
    
    func fetchFoodTrucks(completion: @escaping ([Truck]?) -> () ) {
        let api = "https://data.sfgov.org/resource/jjew-r69b.json"
        let reqmthd = "GET"
        
        var req = URLRequest(url: URL(string: api)!)
        req.httpMethod = reqmthd
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if let err = error {
                NSLog("ERROR GETTING DATA: \(err)")
                completion(nil)
            }
            
            if let dat = data {                
                do {
                    let jsonDecoder = JSONDecoder()
                    let foundtrucks = try jsonDecoder.decode([Truck].self, from: dat)
                    completion(foundtrucks)
                    
                } catch {
                    NSLog("Decoding Error: \(error)")
                    completion(nil)
                }
            }
        }
        .resume()
    }
}
