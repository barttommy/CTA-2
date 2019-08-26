//
//  Extensions.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/9/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIImageView {
    func setImageColor (color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

extension UITextView {
    func setupTrainTextView () {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.font = UIFont.systemFont(ofSize: 16)
        self.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        self.sizeToFit()
        self.isScrollEnabled = false
        self.isEditable = false
        self.textColor = UIColor.white
        self.backgroundColor = AppColor.cellBackground
        self.textColor = AppColor.cellText
    }
}
