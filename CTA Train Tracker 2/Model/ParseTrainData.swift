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

func getTrainArrivalData (for requestedStation: String) -> [Route] {
    var routes = [Route]()
    let apiKey = "73436616b5af4465bc65790aa9d4886c"
    let mapId = ""
    let jsonURLString = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=\(apiKey)&mapid=\(mapId)&=40530&outputType=JSON"
    guard let url = URL(string: jsonURLString) else { return routes }
    
    let group = DispatchGroup()
    group.enter()
    
    URLSession.shared.dataTask(with: url) {(data, response, err) in
        guard let data = data else { return }
        do {
            let arrivals = try JSONDecoder().decode(Root.self, from: data)
            for train in arrivals.ctatt.eta {
                let eta = formatArrivalTime(time: train.arrT)
                let route = Route(line: train.rt, destination: train.destNm, station: train.staNm, etas: [eta])
                let index = routeCellIndex(for: route, in: routes)
                if index > -1 {
                    routes[index].etas.append(eta)
                } else {
                    if route.station == requestedStation {
                        routes.append(route)
                    }
                }
            }
            DispatchQueue.global(qos: .default).async {
                routes.sort(by: {$0.line < $1.line})
                group.leave()
            }
        }
        catch let jsonErr {
            print ("Error parsing JSON: ", jsonErr)
        }
    }.resume()
    group.wait()
    return routes
}

func routeCellIndex(for route: Route, in routes: [Route]) -> Int {
    for i in 0..<routes.count {
        if routes[i].sharesRoute(with: route) {
            return i
        }
    }
    return -1
}

func formatArrivalTime (time: String) -> String {
    var eta = time
    if let index = time.firstIndex(of: "T") {
        let startIndex = time.index(after: index)
        let endIndex = time.index(startIndex, offsetBy: 4)
        let arrivalTime = String(time[startIndex...endIndex])
        let militaryFormat = DateFormatter()
        militaryFormat.dateFormat = "HH:mm"
        if let date = militaryFormat.date(from: arrivalTime) {
            let timeDifference = date.timeIntervalSinceNow
            let hours = floor(timeDifference / 60 / 60)
            let minutes = Int(floor((timeDifference - (hours * 60 * 60)) / 60))
            let standardFormat = DateFormatter()
            standardFormat.dateFormat = "h:mm"
            let expectedArrival = standardFormat.string(from: date)
            let timeRemaining : String
            if minutes == 59 || minutes == 0 {
                timeRemaining = "Now"
            } else {
                timeRemaining = "in \(minutes+1)m"
            }
            eta = "Arriving \(timeRemaining) (\(expectedArrival))"
        }
    }
    return eta
}
