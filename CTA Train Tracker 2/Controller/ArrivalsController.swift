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
    //var routes = [Route]()
    
    var routes: [Route] = {
        var test = Route(type: .blueForest, direction: "Forest Park", station: "Clark/Lake", etas: ["Arriving in 5min", "Arriving in 10min", "Arriving in 15min"])
        var test2 = Route(type: .blueForest, direction: "Forest Park", station: "Clark/Lake", etas: ["Arriving in 5min", "Arriving in 10min", "Arriving in 15min", "Arriving in 15min", "Arriving in 15min"])
        return [test, test2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Incoming Trains"
        collectionView?.backgroundColor = UIColor.rgb(red: 247, green: 247, blue: 247)
        collectionView?.register(ArrivalsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
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
}
