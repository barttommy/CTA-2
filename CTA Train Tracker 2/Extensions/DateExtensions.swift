//
//  DateExtensions.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 9/6/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import Foundation

extension Date {
    func getHour () -> Int? {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour], from: self)
        let hour = comp.hour
        return hour
    }
    
    func convertToStandardFormat() -> String {
        let standardFormat = DateFormatter()
        standardFormat.dateFormat = "h:mm"
        return standardFormat.string(from: self)
    }
    
    func minuteIntervalSinceNow() -> Int {
        let timeDifference = self.timeIntervalSinceNow
        let hours = floor(timeDifference / 60 / 60)
        let minutes = Int(floor((timeDifference - (hours * 60 * 60)) / 60))
        return minutes
    }
}
