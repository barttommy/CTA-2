//
//  ArrivalsCell.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class ArrivalsCell: BaseCell {
    
    let trainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    let arrivalsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.gray
        return textView
    }()
    
    let stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    let routeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(trainImageView)
        addSubview(arrivalsTextView)
        addSubview(stationLabel)
        addSubview(routeLabel)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: trainImageView)
        addConstraintsWithFormat(format: "H:|-64-[v0]-16-|", views: arrivalsTextView)
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-8-[v1]-16-|", views: trainImageView, arrivalsTextView)
        
        // Station Label Constraints
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .bottom, relatedBy: .equal, toItem: routeLabel, attribute: .top, multiplier: 1, constant: -2))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .left, relatedBy: .equal, toItem: trainImageView, attribute: .right, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .right, relatedBy: .equal, toItem: arrivalsTextView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        
        // Route Label Constraints
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .bottom, relatedBy: .equal, toItem: arrivalsTextView, attribute: .top, multiplier: 1, constant: -6))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .left, relatedBy: .equal, toItem: trainImageView, attribute: .right, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .right, relatedBy: .equal, toItem: arrivalsTextView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
    }
}

