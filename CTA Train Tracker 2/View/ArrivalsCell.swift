//
//  ArrivalsCell.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class ArrivalsCell: BaseCell {
    var route: Route? {
        didSet {
            if let station = route?.station {
                stationLabel.text = station
            }
            if let destination = route?.destination {
                routeLabel.text = "To: \(destination)"
            }
            if let etas = route?.etas {
                let length = etas.count - 1
                for i in 0..<length {
                    arrivalsTextView.text.append("\(etas[i])\n")
                }
                arrivalsTextView.text.append("\(etas[length])")
            }
            if let color = route?.color {
                trainImageView.setImageColor(color: color)
                routeLabel.textColor = color
            }
        }
    }
    
    let trainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "train_image")
        return imageView
    }()
    
    let arrivalsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let routeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.rgb(red: 22, green: 189, blue: 245)
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        arrivalsTextView.text = ""
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(trainImageView)
        addSubview(arrivalsTextView)
        addSubview(stationLabel)
        addSubview(routeLabel)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: trainImageView)
        addConstraintsWithFormat(format: "H:|-68-[v0]-16-|", views: arrivalsTextView)
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-8-[v1]", views: trainImageView, arrivalsTextView)
        
        // Station Label Constraints
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .bottom, relatedBy: .equal, toItem: routeLabel, attribute: .top, multiplier: 1, constant: -2))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .left, relatedBy: .equal, toItem: trainImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .right, relatedBy: .equal, toItem: arrivalsTextView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stationLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        
        // Route Label Constraints
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .bottom, relatedBy: .equal, toItem: arrivalsTextView, attribute: .top, multiplier: 1, constant: -6))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .left, relatedBy: .equal, toItem: trainImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .right, relatedBy: .equal, toItem: arrivalsTextView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: routeLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
    }
}
