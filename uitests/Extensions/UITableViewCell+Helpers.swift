//
//  UITableViewCell+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Static variable that returns the UITableViewCell's subclass name
    ///
    /// The purpose of this static variable is to eliminate the need to create an enum of CellIdentifiers. For this to work, you have to set the `reuseIdentifier` of your UITableViewCell in your storyboard to the UITableViewCell's subclass name.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
