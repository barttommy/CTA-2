//
//  Route.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class Route {
    let color : UIColor
    let line : String
    let station : String
    let destination : String
    var etas : [ETA]
    
    init (line: String, destination: String, station: String, etas : [ETA]) throws {
        if line == "Brn" {
            color = TrainColor.brown
        } else if line == "P" {
            color = TrainColor.purple
        } else if line == "Red" {
            color = TrainColor.red
        } else if line == "Blue" {
            color = TrainColor.blue
        } else if line == "G" {
            color = TrainColor.green
        } else if line == "Org" {
            color = TrainColor.orange
        } else if line == "Pink" {
            color = TrainColor.pink
        } else if line == "Y" {
            color = TrainColor.yellow
        } else {
            throw TrainError.invalidLine
        }
        if destination == "See train" {
            throw TrainError.invalidDestination
        }
        if etas.count == 4 {
            throw TrainError.trainLimitReached
        }
        self.line = line
        self.destination = destination
        self.station = station
        self.etas = etas
    }
    
    func sharesRoute (with route: Route) -> Bool {
        if self.line == route.line && self.destination == route.destination && self.station == route.station {
            return true
        } else {
            return false
        }
    }
}
