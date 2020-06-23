//
//  Truck.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import Foundation
import MapKit

struct Truck: Decodable {
    let applicant: String
    let location: String
    let optionaltext: String?
    let dayofweekstr: String
    let starttime: String
    let endtime: String
    let latitude: String
    let longitude: String
    let start24: String
    let end24: String
    
    var coordinates: CLLocationCoordinate2D? {
        var coord: CLLocationCoordinate2D
        if let lat = Double(latitude), let lon = Double(longitude) {
            coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            return coord
        }
        return nil
    }
    
    var opens: Date? {
        return getTime(from: start24)
    }
    
    var closes: Date? {
        return getTime(from: end24)
    }
    
    private func getTime(from timeString: String) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if let date = formatter.date(from: timeString) {
            let components = calendar.dateComponents([.hour, .minute, .second], from: date)
            
            guard let hour = components.hour, let minutes = components.minute, let seconds = components.second else { return nil }
            
            let openingTime = calendar.date(bySettingHour: hour, minute: minutes, second: seconds, of: Date())
            
            return openingTime
        } else {
            return nil
        }
    }
}
