//
//  Int+Helpers.swift
//  App
//
//  Created by Maria Rosa Santiago on 6/7/21.
//  Copyright © 2021 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation

extension Int {
    
    func formatUsingAbbrevation () -> String {
        let abbrev = "KMBTPE"
        if numberOfDigits(in: self) > 4{
        return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.0f%@")
            return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
        }else{
            return String(self)
        }
    }
}

extension Double {
    
    func UTCToLocal() -> Double {
        var milliseconds = self
        if milliseconds < 999999999999 {
            milliseconds = milliseconds * 1000
        }
        let date = Date(milliseconds: milliseconds)
        let utcFormatter = DateFormatter()
        utcFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        utcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcDate = utcFormatter.date(from: utcFormatter.string(from: date))
        
        let currentTimeZoneFormatter = DateFormatter()
        currentTimeZoneFormatter.locale = Locale(identifier: "en_US")
        currentTimeZoneFormatter.timeZone = TimeZone.current
        currentTimeZoneFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimezonDate = currentTimeZoneFormatter.date(from: currentTimeZoneFormatter.string(from: utcDate!))
        return currentTimezonDate!.millisecondsSince1970
    }
    
    func UTCToLocal(chosenDateFormat:String)-> String {
        var milliseconds = self
        if milliseconds < 999999999999 {
            milliseconds = milliseconds * 1000
        }
        let date = Date(milliseconds: milliseconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: dateFormatter.string(from: date))
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = chosenDateFormat
        return dateFormatter.string(from: dt!)
    }
    
    func formatTimeMillis(chosenDateFormat: String)-> String {
        var milliseconds = self
        if milliseconds < 999999999999 {
            milliseconds = milliseconds * 1000
        }
        let date = Date(milliseconds: milliseconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = chosenDateFormat
        return dateFormatter.string(from: date)
    }
    
    func formatUsingAbbrevation () -> String {
        let abbrev = "KMBTPE"
        let numOfDigits = numberOfDigits(in: self.toInt() ?? 0)
        if numOfDigits > 4 {
            return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
                let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.0f%@")
                return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
                } ?? String(self)
        }else{
            return String (self.toInt() ?? 0)
        }
    }

    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}

// private recursive method for counting digits
private func numberOfDigits(in number: Int) -> Int {
    if number < 10 && number >= 0 || number > -10 && number < 0 {
        return 1
    } else {
        return 1 + numberOfDigits(in: number/10)
    }
}
