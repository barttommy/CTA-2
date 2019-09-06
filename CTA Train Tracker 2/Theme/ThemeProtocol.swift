//
//  ThemeProtocol.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var viewBackgroundColor: UIColor { get }
    var cellBackgroundColor: UIColor { get }
    var cellTextColor: UIColor { get }
    var navBarColor: UIColor { get }
    var navBarTintColor: UIColor { get }
    var navBarButtonColor: UIColor { get }
    var statusBarStyle: UIBarStyle { get }
}
