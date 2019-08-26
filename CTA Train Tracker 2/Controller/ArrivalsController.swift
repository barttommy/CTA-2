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
        fetchTrainData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Incoming Trains"
        collectionView?.backgroundColor = AppColor.viewBackground
        collectionView?.register(ArrivalsCell.self, forCellWithReuseIdentifier: cellId)
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let refreshImage = UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate)
        let refreshButton = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(fetchTrainData))
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(pushSearchController))
        refreshButton.tintColor = AppColor.navBarButtons
        searchButton.tintColor = AppColor.navBarButtons
        navigationItem.rightBarButtonItems = [refreshButton, searchButton]
    }
    
    @objc func fetchTrainData() {
        routes.removeAll()
        routes = getTrainArrivalData(for: requestedStation)
        self.collectionView?.reloadData()
    }
    
    @objc func pushSearchController() {
        self.navigationController?.pushViewController(SearchController(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = routes.count
        if count == 0 {
            self.collectionView.displayNoTrainsFoundError()
        } else {
            self.collectionView.restore()
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArrivalsCell
        cell.route = routes[indexPath.item]
        cell.backgroundColor = AppColor.cellBackground
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textViewHeight = CGFloat(routes[indexPath.item].etas.count) * 19.5
        return CGSize(width: view.frame.width - 32, height: 68 + textViewHeight + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
