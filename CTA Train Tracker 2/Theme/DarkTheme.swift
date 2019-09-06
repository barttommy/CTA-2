//
//  DarkTheme.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    var viewBackgroundColor = UIColor.rgb(red: 40, green: 40, blue: 40)
    var cellBackgroundColor = UIColor.rgb(red: 70, green: 70, blue: 70)
    var cellTextColor = UIColor.white
    var navBarColor = UIColor.rgb(red: 55, green: 55, blue: 55)
    var navBarTintColor = UIColor.white
    var navBarButtonColor = UIColor.white
    var statusBarStyle: UIBarStyle = .blackOpaque
}
