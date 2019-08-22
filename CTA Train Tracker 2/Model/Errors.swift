//
//  Errors.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/22/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import Foundation

enum TrainError: Error {
    case invalidLine
    case invalidDestination
    case trainLimitReached
}
