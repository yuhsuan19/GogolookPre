//
//  DateExtension.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation

extension Date {
    func isSame(as date: Date) -> Bool {
        return (date.compare(self) == .orderedSame)
    }
    
    func isEarlierThan(_ date: Date) -> Bool {
        return (date.compare(self) == .orderedDescending)
    }
    
    func isLaterThan(_ date: Date) -> Bool {
        return (date.compare(self) == .orderedAscending)
    }
    
    func isSameDay(as date: Date, in timeZone: Calendar.Identifier? = nil) -> Bool {
        var calendar: Calendar
        if let timeZone = timeZone {
            calendar = Calendar(identifier: timeZone)
        } else {
            calendar = Calendar.current
        }
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    func startOfDay(in timeZone: Calendar.Identifier? = nil) -> Date {
        var calendar: Calendar
        if let timeZone = timeZone {
            calendar = Calendar(identifier: timeZone)
        } else {
            calendar = Calendar.current
        }
        return calendar.startOfDay(for: self)
    }
    
    func endOfDay(in timeZone: Calendar.Identifier? = nil) -> Date {
        return Date(timeInterval: (60 * 60 * 24) - 1, since: self.startOfDay(in: timeZone))
    }
    
    func nowAge(in timeZone: Calendar.Identifier? = nil) -> Int {
        var calendar: Calendar
        if let timeZone = timeZone {
            calendar = Calendar(identifier: timeZone)
        } else {
            calendar = Calendar.current
        }
        
        let calculatedAge = calendar.dateComponents([.year], from: self, to: Date())
        return calculatedAge.year ?? .zero
    }
}
