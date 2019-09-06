//
//  UITextViewExtensions.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

extension UITextView {
    func setupTrainTextView () {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.font = UIFont.systemFont(ofSize: 16)
        self.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        self.sizeToFit()
        self.isScrollEnabled = false
        self.isEditable = false
        self.backgroundColor = AppColor.cellBackground
        self.textColor = AppColor.cellText
    }
}
