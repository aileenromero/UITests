//
//  DesignableTextField.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 10/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

/// A subclass of UITextField, assign this subsclass to a UITextField in Storyboard to edit properties on Storyboard directly.
///
@IBDesignable
class DesignableTextField: UITextField {
    
    /// Property that sets the padding of DesignableTextField. NOTE: Value set will be applied to all UITextField using DesignableTextField subclass.
    ///
    var padding = UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 8);
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// Override function to modify editingRect according to padding variable declared above
    ///
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    /// Override function to modify placeholderRect according to padding variable declared above
    ///
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    /// Override function to modify textRect according to padding variable declared above
    ///
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
