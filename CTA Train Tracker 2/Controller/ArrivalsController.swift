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
        routes = getTrainArrivalData(for: requestedStation)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Incoming Trains"
        collectionView?.backgroundColor = UIColor.rgb(red: 247, green: 247, blue: 247)
        collectionView?.register(ArrivalsCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let refreshImage = UIImage(named: "refresh")?.withRenderingMode(.alwaysOriginal)
        let refreshButton = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(handleRefresh))
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItems = [refreshButton, searchButton]
    }
    
    @objc func handleRefresh() {
        routes.removeAll()
        routes = getTrainArrivalData(for: requestedStation)
        self.collectionView?.reloadData()
    }
    
    @objc func handleSearch() {
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArrivalsCell
        cell.route = routes[indexPath.item]
        cell.addRoundedEdges()
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
