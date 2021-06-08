//
//  UIImage+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 29/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - Methods:
    // MARK: Instance
    
    /// [How to compress of reduce the size of an image before uploading to
    /// Parse as PFFile? (Swift)](http://stackoverflow.com/a/42293258/968219)
    /// - parameter expectedSizeInMb: The expected size to compress the image to.
    /// - returns: The JPEG `Data` representation of the `UIImage`.
    @available(iOS, introduced: 9.3)
    func JPEGRepresentationAt(_ expectedSizeInMb: Double) -> Data? {
        let sizeInBytes = Int(expectedSizeInMb * 1024 * 1024)
        var needCompress = true
        var imgData: Data?
        var compressingValue: CGFloat = 1
        while (needCompress) {
            if let data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            } else {
                needCompress = false
                imgData = self.jpegData(compressionQuality: 1)
            }
        }
        
        return imgData
    }
    
    /// Method that addresses issue with uploading portrait images taken from camera
    /// https://stackoverflow.com/questions/10850184/ios-image-get-rotated-90-degree-after-saved-as-png-representation-data
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
    
    // For inverting image's color
    func inverseImage(cgResult: Bool) -> UIImage? {
        let coreImage = UIKit.CIImage(image: self)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return nil }
        if cgResult { // I've found that UIImage's that are based on CIImages don't work with a lot of calls properly
            return UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
        }
        return UIImage(ciImage: result)
      }
}

extension UIImage {

    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let aspectWidth = rect.width / width
        let aspectHeight = rect.height / height
        let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
      let rect = CGRect(origin: .zero, size: size)
      UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
      color.setFill()
      UIRectFill(rect)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      guard let cgImage = image?.cgImage else { return nil }
      self.init(cgImage: cgImage)
    }
    
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            let newImage = image
            UIGraphicsEndImageContext()
            return newImage
        }else{
            let newImage = UIImage()
            UIGraphicsEndImageContext()
            return newImage
        }
    }
    
    func tintImage(with color: UIColor) -> UIImage? {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
    
    func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
