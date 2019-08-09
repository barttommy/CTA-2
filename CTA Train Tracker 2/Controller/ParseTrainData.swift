//
//  ParseTrainData.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import Foundation

struct Root : Decodable {
    struct StationData : Decodable {
        let eta : [Arrivals]
    }
    let ctatt : StationData
}

struct Arrivals : Decodable {
    let staNm  : String
    let rt     : String
    let destNm : String
    let arrT   : String
}
