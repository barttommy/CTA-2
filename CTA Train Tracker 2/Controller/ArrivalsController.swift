//
//  ViewController.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class ArrivalsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "route"
    var requestedStation = "Fullerton"
    var routes = [Route]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getTrainArrivalData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Incoming Trains"
        navigationItem.titleView = titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.rgb(red: 247, green: 247, blue: 247)
        collectionView?.register(ArrivalsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArrivalsCell
        
        cell.route = routes[indexPath.item]
        
        cell.backgroundColor = UIColor.white
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textViewHeight = CGFloat(routes[indexPath.item].etas.count) * 19.5
        return CGSize(width: view.frame.width - 32, height: 68 + textViewHeight + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func getTrainArrivalData () {
        routes.removeAll()
        let apiKey = "73436616b5af4465bc65790aa9d4886c"
        let mapId = ""
        let jsonURLString = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=\(apiKey)&mapid=\(mapId)&=40530&outputType=JSON"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            guard let data = data else { return }
            do {
                let arrivals = try JSONDecoder().decode(Root.self, from: data)
                for train in arrivals.ctatt.eta {
                    let type = self.getTrainType(line: train.rt, destination: train.destNm)
                    let eta = self.formatArrivalTime(time: train.arrT)
                    if type != .unknown {
                        let route = Route(type: type, direction: train.destNm, station: train.staNm, etas: [eta])
                        let index = self.routeCellIndex(for: route)
                        if index > -1 {
                            self.routes[index].etas.append(eta)
                        } else {
                            if route.station == self.requestedStation {
                                self.routes.append(route)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.routes.sort(by: {$0.type.rawValue < $1.type.rawValue})
                    self.collectionView?.reloadData()
                }
            }
            catch let jsonErr {
                print ("Error parsing JSON: ", jsonErr)
            }
        }.resume()
    }
    
    func routeCellIndex(for route: Route) -> Int {
        for i in 0..<routes.count {
            if routes[i].sharesRoute(with: route) {
                return i
            }
        }
        return -1
    }
    
    func getTrainType (line: String, destination: String) -> TrainType {
        var type : TrainType
        if line == "Brn" && destination == "Loop" {
            type = .brownLoop
        } else if line == "Brn" && destination == "Kimball" {
            type = .brownKimbal
        } else if line == "P" && destination == "Loop" {
            type = .purpleLoop
        } else if line == "P" && destination == "Linden" {
            type = .purpleLinden
        } else if line == "Red" && destination == "Howard" {
            type = .redHoward
        } else if line == "Red" && destination == "95th/Dan Ryan" {
            type = .red95th
        } else if line == "Blue" && destination == "Forest Park" {
            type = .blueForest
        } else if line == "Blue" && destination == "O'Hare" {
            type = .blueOhare
        } else if line == "G" && destination == "Ashland/63rd" {
            type = .greenAshland
        } else if line == "G" && destination == "Harlem/Lake" {
            type = .greenHarlem
        } else if line == "G" && destination == "Cottage Grove" {
            type = .greenCottage
        } else if line == "Org" && destination == "Midway" {
            type = .orangeMidway
        } else if line == "Org" && destination == "Loop" {
            type = .orangeLoop
        } else if line == "Pink" && destination == "54th/Cermak" {
            type = .pinkCermak
        } else if line == "Pink" && destination == "Loop" {
            type = .pinkLoop
        } else {
            type = .unknown
        }
        return type
    }
    
    // Might be worth writing this as an extension? For time difference part
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
}
