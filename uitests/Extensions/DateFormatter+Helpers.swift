//
//  DateFormatter+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// Convenience initializer that takes a string format ('MMMM-dd-yyyy') and a string locale ('en_US').
    ///
    /// - parameters:
    ///     - format: The string format ('MMMM-dd-yyyy')
    ///     - locale: The string locale to be used ('en_US')
    convenience init(withFormat format : String, locale : String) {
        self.init()
        self.locale = Locale(identifier: locale)
        dateFormat = format
    }
    
}
