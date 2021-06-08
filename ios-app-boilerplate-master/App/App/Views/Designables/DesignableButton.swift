//
//  DesignableButton.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 10/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

/// A subclass of UIButton, assign this subsclass to a UIButton in Storyboard to edit properties on Storyboard directly.
///
@IBDesignable
class DesignableButton: UIButton {
    
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
    
    @IBInspectable var imageEdgeInsetLeft: CGFloat {
        get {
            return imageEdgeInsets.left
        }
        set {
            imageEdgeInsets.left = newValue
        }
    }
    
    @IBInspectable var titleEdgeInsetLeft: CGFloat {
        get {
            return titleEdgeInsets.left
        }
        set {
            titleEdgeInsets.left = newValue
        }
    }
    
    @IBInspectable var titleEdgeInsetRight: CGFloat {
        get {
            return titleEdgeInsets.right
        }
        set {
            titleEdgeInsets.right = newValue
        }
    }
}
