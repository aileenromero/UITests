//
//  String+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// Checks if the string is a valid email address.
    ///
    /// - returns: Returns `true` if the string is a valid email address, otherwise `false`.
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func toTimeAgoString() -> String {
        let convertedDate = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss", locale: "en_US").date(from: self)
        return convertedDate?.getElapsedInterval() ?? "Not valid string."
    }
    
    func toTime() -> String{
        let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss", locale: "en_US")
        let convertedDate = dateFormatter.date(from: self)
        guard convertedDate != nil else{
            return "Not valid string"
        }
        dateFormatter.dateFormat = "h:mm a"
        let convertedString = dateFormatter.string(from: convertedDate!)
        return convertedString
    }
    
    func UTCToLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func insertCharacter(string: String, index: Int) -> String {
        return  String(self.prefix(index)) + string + String(self.suffix(self.count-index))
    }
    
    func isNumeric() -> Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    /// Apply color to array of strings specified
    ///
    /// - parameters:
    ///     - strings: array of strings to be colored
    ///     - color: color to apply to specified strings
    ///     - characterSpacing: used for kerning
    /// - returns: Returns attributed string.
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    
    /// Capitalize first letter on a string
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

}

/// This extension enables strings to be treated as Errors.
extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

/// This extension extracts integer or double value from String.
extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
}
