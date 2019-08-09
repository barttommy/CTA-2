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
        imageView.backgroundColor = UIColor.green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let arrivalsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(trainImageView)
        addSubview(arrivalsTextView)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: trainImageView)
        addConstraintsWithFormat(format: "H:|-64-[v0]-16-|", views: arrivalsTextView)
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-8-[v1]-16-|", views: trainImageView, arrivalsTextView)
    }
}

