//
//  ParseTrainData.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import Foundation

// For JSON Parsing
struct Root : Decodable {
    struct StationData : Decodable {
        let eta : [Arrivals]
    }
    let ctatt : StationData
}

// For JSON Parsing
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
        guard let data = data else {
            group.leave()
            return
        }
        do {
            let arrivals = try JSONDecoder().decode(Root.self, from: data)
            for train in arrivals.ctatt.eta {
                do {
                    let eta = formatArrivalTime(time: train.arrT)
                    let route = try Route(line: train.rt, destination: train.destNm, station: train.staNm, etas: [eta])
                    let index = routeCellIndex(for: route, in: routes)
                    if index > -1 {
                        routes[index].etas.append(eta)
                    } else {
                        if route.station == requestedStation {
                            routes.append(route)
                        }
                    }
                } catch is TrainError { }
            }
            DispatchQueue.global(qos: .default).async {
                routes.sort(by: {$0.line < $1.line})
                group.leave()
            }
        }
        catch let jsonErr {
            group.leave()
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

/*  Converts string of the format "YYYY-MM-DDT24:00:00"
    Ex. For the string "YYYY-MM-DDT24:00:00"
        arrivalTime = Arriving at 12:00 am
        timeRemaining = 10 min
 */
func formatArrivalTime (time: String) -> ETA {
    var arrivalTime = time
    var timeRemaining = ""
    if let index = time.firstIndex(of: "T") {
        let startIndex = time.index(after: index)
        let endIndex = time.index(startIndex, offsetBy: 4)
        let arrivalTimeString = String(time[startIndex...endIndex])
        let militaryFormat = DateFormatter()
        militaryFormat.dateFormat = "HH:mm"
        if let date = militaryFormat.date(from: arrivalTimeString) {
            let minutes = date.minuteIntervalSinceNow()
            timeRemaining = (minutes == 59 || minutes == 0) ? "Due" : "\(minutes+1) min"
            var timeOfDay = ""
            if let hour = date.getHour() {
                timeOfDay = (hour >= 12) ? "pm" : "am"
            }
            let expectedArrival = date.convertToStandardFormat()
            arrivalTime = "Arriving at \(expectedArrival) \(timeOfDay)"
        }
    }
    return ETA.init(arrivalTime: arrivalTime, timeRemaining: timeRemaining)
}
