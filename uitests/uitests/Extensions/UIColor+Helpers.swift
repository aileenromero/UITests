//
//  UIColor+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    /// Converts hex value to UIColor
    ///
    /// - parameters:
    ///     - hex: The hex value of the color (Replace '#' with '0x')
    ///     - alpha: The alpha of the color (default = 1.0)
    ///
    /// - returns: Returns UIColor converted from hex and alpha
    class func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    
    func isLight() -> Bool {
        guard let components = cgColor.components,
            components.count >= 3 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return !(brightness < 0.5)
    }
    
    public var complementaryColor: UIColor {
        return isLight() ? darker : lighter
    }
    
    public var lighter: UIColor {
        return adjust(by: 1.35)
    }
    
    public var darker: UIColor {
        return adjust(by: 0.94)
    }
    
    func adjust(by percent: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * percent, alpha: a)
    }
    
    func makeGradient() -> [UIColor] {
        return [self, self.complementaryColor, self]
    }
}



extension UIColor {
    
    static let primaryColor = UIColor(hex: "#F26022")!
    static let primaryColorLightVariant = UIColor(hex: "#FF9151")!
    static let primaryColorDarkVariant = UIColor(hex: "#B82D00")!
    static let secondaryColor = UIColor(hex: "#1966B1")!
    // No secondaryColorVariant...
    static let backgroundColor = UIColor(hex: "#1966B1")!
    static let surfaceColor = UIColor(hex: "#5C93E3")!
    static let errorColor = UIColor(hex: "#003C81")!
    static let onPrimaryColor = UIColor(hex: "#000000")!
    // No onPrimaryColorVariant...
    static let onSecondaryColor = UIColor(hex: "#1966B1")!
    // No onSecondaryColorVariant...
    static let onBackgroundColor = UIColor(hex: "#000000")!
    static let onSurfaceColor = UIColor(hex: "#000000")!
    // No onErrorColor...
    
}
