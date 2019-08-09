//
//  Route.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import Foundation

class Route {
    var type : TrainType
    var station : String
    var direction : String
    var etas : [String]
    
    init (type: TrainType, direction: String, station: String, etas : [String]) {
        self.type = type
        self.direction = direction
        self.station = station
        self.etas = etas
    }
    
    func sharesRoute (with route: Route) -> Bool {
        if self.type == route.type && self.direction == route.direction && self.station == route.station {
            return true
        } else {
            return false
        }
    }
}
