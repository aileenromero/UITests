//
//  UIFont+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 11/07/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let regular = UIFont(name: "TitilliumWeb-Regular", size: 12.0)!
    static let light = UIFont(name: "TitilliumWeb-Light", size: 12.0)!
    static let semibold = UIFont(name: "TitilliumWeb-SemiBold", size: 12.0)!
    static let bold = UIFont(name: "TitilliumWeb-Bold", size: 12.0)!
    
    class func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "TitilliumWeb-Regular", size: size)!
    }
    
    class func light(size: CGFloat) -> UIFont {
        return UIFont(name: "TitilliumWeb-Light", size: size)!
    }
    
    class func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "TitilliumWeb-SemiBold", size: size)!
    }
    
    class func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "TitilliumWeb-Bold", size: size)!
    }
    
}
