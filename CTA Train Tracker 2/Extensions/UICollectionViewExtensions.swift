//
//  UICollectionViewExtensions.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

extension UICollectionView {
    func displayNoTrainsFoundError() {
        let errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let title = "No Trains Found\n"
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let errorMessage = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let subtitle = "There are no incoming trains at this station.\nMake sure that you are connected to the internet."
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let subtitleString = NSMutableAttributedString(string: subtitle, attributes: subtitleAttributes)
        errorMessage.append(subtitleString)
        
        errorLabel.attributedText = errorMessage
        errorLabel.textColor = AppColor.cellText
        errorLabel.numberOfLines = 5
        errorLabel.textAlignment = .center
        errorLabel.sizeToFit()
        
        self.backgroundView = errorLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
