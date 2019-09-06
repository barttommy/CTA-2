//
//  UIImageViewExtensions.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageColor (color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
