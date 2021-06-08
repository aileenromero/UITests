//
//  UIView+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    
    /// Adds a shadow effect to UIView
    ///
    func dropShadow() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
    }
    
    func applyDropShadow(opacity: Float, offset: CGSize, radius: CGFloat = 3.0){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    func dropShadowForView(scale: Bool = true, color: CGColor = UIColor.darkGray.cgColor){
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowForCard(verticalLocation: VerticalLocation = .bottom) {
        layer.shadowColor = UIColor.gray.cgColor
        if verticalLocation == .bottom{
            layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        }else {
            layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        }
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 6
        layer.masksToBounds = false
        layer.cornerRadius = 10.0
    }
    
    func dropShadowForCircle(cornerRadius: CGFloat, shadowColor:UIColor = UIColor.gray, shadowRadius: CGFloat = 6,
                             shadowOffset:CGSize = CGSize(width: 0.0, height: 3.0)){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 0.3
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        //        layer.shadowColor = UIColor.gray.cgColor
        //        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        //        layer.shadowOpacity = 0.3
        //        layer.shadowRadius = 6
        //        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 100).cgPath
    }
    
    func innerDropShadow(offset: CGSize = CGSize.zero, opacity: Float = 1){
        backgroundColor = .clear
        
        let innerShadowLayer = CALayer()
        innerShadowLayer.frame = bounds
        
        let radius = self.frame.size.height/2
        let path = UIBezierPath(roundedRect: innerShadowLayer.bounds.insetBy(dx: -3, dy: -3), cornerRadius: radius)
        let innerPart = UIBezierPath(roundedRect: innerShadowLayer.bounds, cornerRadius: radius).reversing()
       // let path = UIBezierPath(rect: innerShadowLayer.bounds.insetBy(dx: -20, dy: -20))
       // let innerPart = UIBezierPath(rect: innerShadowLayer.bounds).reversing()
        path.append(innerPart)
        innerShadowLayer.shadowPath = path.cgPath
        innerShadowLayer.masksToBounds = true
        
        innerShadowLayer.shadowColor = UIColor.black.cgColor
        innerShadowLayer.shadowOffset = offset
        innerShadowLayer.shadowOpacity = opacity
        innerShadowLayer.shadowRadius = 2
        //innerShadowLayer.cornerRadius = self.bounds.width / 2
        layer.addSublayer(innerShadowLayer)
    }
    
    /// Makes the UIView's shape rounded (Used mainly on UIImageView)
    ///
    func setRounded() {
        let radius = frame.width / 2
        layer.cornerRadius = radius
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    var changeViewToImage: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func applyGradient(firstColor: Int, secondColor: Int) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        guard let rgbFirst = Int("0x\(firstColor)") else { return }
        guard let rgbSecond = Int("0x\(secondColor)") else { return }
        gradient.colors = [
            UIColor.colorWithRGBHex(rgbFirst),
            UIColor.colorWithRGBHex(rgbSecond)
        ]
        if layer.sublayers?.count ?? 0 > 1{
            layer.replaceSublayer(layer.sublayers![0], with: gradient)
        }else{
            layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func applyGradient(firstColor: UIColor, secondColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            firstColor.cgColor,
            secondColor.cgColor
        ]
        if layer.sublayers?.count ?? 0 > 1{
            layer.replaceSublayer(layer.sublayers![0], with: gradient)
        }else{
            layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func applyGradient(colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = []
        for color in colors {
            gradient.colors?.append(color.cgColor)
        }
        
        if layer.sublayers?.count ?? 0 > 1{
            layer.replaceSublayer(layer.sublayers![0], with: gradient)
        }else{
            layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func applyGradient(firstColorHex: String, secondColorHex: String) {
        guard let firstColor = UIColor(hex: firstColorHex), let secondColor = UIColor(hex: secondColorHex) else {
            return
        }
        applyGradient(firstColor: firstColor, secondColor: secondColor)
    }
    
    func applyGradient(colors:[String]){
        var uiColorArray = [UIColor]()
        for color in colors {
            let uiColorValue = UIColor(hex: color)
            if uiColorValue != nil {
                uiColorArray.append(uiColorValue!)
            }
        }
        applyGradient(colors: uiColorArray)
    }
    
    
    /// This function applies a radial gradient to a view.
    ///
    ///
    /// Usage:
    ///
    ///     let view = UIView()
    ///     view.applyRadialGradient(colors: [0x4B4B4B, 0x000000],
    ///                         startPoint: CGPoint(x: 0, y: 0.),
    ///                         endPoint: CGPoint(x: 1, y: 1))
    ///
    /// - Parameter colors: An array of hex colors (Replace ‘#’ with ‘0x’)
    /// - Parameter startPoint: represents the middle of the circle
    /// - Parameter endPoint: represents the farthest point of the circle.
    ///
    /// - Note:First (index) color appears in the inner most circler, while last is the farthest
    /// - Note: Adjust *startPoint* and *endPoint* to your liking till your desired effect is achieved
    /// - Note:[Reference](https://medium.com/swlh/how-to-create-a-custom-gradient-in-swift-with-cagradientlayer-ios-swift-guide-190941cb3db2)
    ///
    ///
    func applyRadialGradient(colors: [Int], startPoint: CGPoint, endPoint: CGPoint){
        let radialGradient = CAGradientLayer()
        var cgColors: [CGColor] = []
        radialGradient.type = CAGradientLayerType.radial
        
        for color in colors{
            cgColors.append(UIColor.colorWithRGBHex(color).cgColor)
        }
        radialGradient.colors = cgColors
        radialGradient.startPoint = startPoint
        radialGradient.endPoint = endPoint
        
        //needs to be async beacause Addition Information View in Reward Details VC has a delay in updating its frame
        DispatchQueue.main.async {
            radialGradient.frame = self.frame
            if self.layer.sublayers?.count ?? 0 >= 1{
                self.layer.replaceSublayer(self.layer.sublayers![0], with: radialGradient)
            }else{
                self.layer.insertSublayer(radialGradient, at: 0)
            }
        }
    }
    
    func removeGradientSublayer(){
        guard let layerCount = layer.sublayers?.count else{
            return
        }
        
        if layerCount > 1 {
            layer.sublayers?.remove(at: 0)
        }
    }
    
    func rootView() -> UIView {
        return superview?.rootView() ?? superview ?? self
    }
    
    func cutRect(holeRect: CGRect, inView view: UIView) {
        let combinedPath = CGMutablePath()
        combinedPath.addRect(view.bounds)
        combinedPath.addRect(holeRect)
        
        
        let maskShape = CAShapeLayer()
        maskShape.path = combinedPath
        maskShape.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.mask = maskShape
    }
    
    func cutRounded(holeRect: CGRect, inView view: UIView, cornerRadius: CGFloat) {
        let combinedPath = CGMutablePath()
        combinedPath.addRect(view.bounds)
        
        combinedPath.addRoundedRect(in: holeRect, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        
        let maskShape = CAShapeLayer()
        maskShape.path = combinedPath
        maskShape.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.mask = maskShape
    }
    
    func cutRounded(holeRect: [CGRect], inView view: UIView, cornerRadius: [CGFloat]) {
        let combinedPath = CGMutablePath()
        combinedPath.addRect(view.bounds)
        
        for (index,rect) in holeRect.enumerated(){
            combinedPath.addRoundedRect(in: rect, cornerWidth: cornerRadius[index], cornerHeight: cornerRadius[index])
        }
        
        let maskShape = CAShapeLayer()
        maskShape.path = combinedPath
        maskShape.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.mask = maskShape
    }
    
    func cutDiagonal(withDirection direction: DiagonalCutMode = .fromRightToLeft){
        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width

        let path = UIBezierPath()
        let pointA = CGPoint(x: 0, y: 0)
        var pointB: CGPoint{
            switch direction{
                case .fromLeftToRight:
                    return CGPoint(x: 0, y: layerHeight)
                case .fromRightToLeft:
                    return CGPoint(x: layerWidth, y: 0)
            }
        }
        var pointC: CGPoint{
            switch direction {
                case .fromLeftToRight:
                    return CGPoint(x: layerWidth, y: 0)
                case .fromRightToLeft:
                    return CGPoint(x: layerWidth, y: layerHeight)
            }
        }
        let pointD = CGPoint(x: 0, y: 0)
        
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.addLine(to: pointC)
        path.addLine(to: pointD)
        path.close()
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    enum DiagonalCutMode: Int{
        case fromLeftToRight = 0
        case fromRightToLeft = 1
    }
    
    func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
}
