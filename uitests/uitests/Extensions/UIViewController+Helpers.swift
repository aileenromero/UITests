//
//  UIViewController+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit
import Kingfisher

extension UIViewController {
    
    /// Presents a UIAlertController with title and message
    ///
    /// - parameters:
    ///     - title: The title of the UIAlertController
    ///     - message: The message of the UIAlertController
    ///
    /// - return: Returns a `@discardableResult` UIAlertController.
    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(dismissAlertAction)
        
        present(alertController, animated: true, completion: nil)
        
        return alertController
    }
    
    /// Presents a UIAlertController with title, message, and completion block
    ///
    /// - parameters:
    ///     - title: The title of the UIAlertController
    ///     - message: The message of the UIAlertController
    ///     - withBlock completion: Code to be executed after the user taps on "OK" button
    ///
    /// - return: Returns a `@discardableResult` UIAlertController.
    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?, withBlock completion: @escaping () -> Void ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            completion()
        }
        
        alertController.addAction(dismissAlertAction)
        
        present(alertController, animated: true, completion: nil)
        
        return alertController
    }
    
    /// Presents a loading UIAlertController with title and message
    ///
    /// - parameters:
    ///     - title: The title of the loading UIAlertController (Default = "Loading...")
    ///     - completion: Code to be executed after presenting the loading UIAlertController
    ///
    /// - return: Returns the UIAlertController.
    func presentLoadingAlertController(title: String? = "Loading...", completion: (() -> Swift.Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: "Please wait.", preferredStyle: .alert)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 110)
        alertController.view.addConstraint(height);
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: alertController.view.bounds)
        loadingIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingIndicator.style = .gray
        loadingIndicator.center = CGPoint(x: alertController.view.center.x, y: alertController.view.center.y + 25)
        alertController.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        
        present(alertController, animated: true, completion: completion)
        
        return alertController
    }
    
    /// Presents a UIAlertController which takes an Error's localized description and presents it to the user.
    ///
    /// - parameters:
    ///     - error: The Error you want to present
    ///
    func presentErrorAlertController(error: Error) {
        let message = error.localizedDescription
        presentDismissableAlertController(title: "Error", message: message)
    }
    
    /// Presents a UIAlertController which takes an Error's localized description and presents it to the user. Additionally, it takes a completion block to be executed after the user taps on the `OK` button.
    ///
    /// - parameters:
    ///     - error: The Error you want to present
    ///     - withBlock completion: Code to be executed after the user taps on "OK" button
    ///
    /// - return: Returns a `@discardableResult` UIAlertController.
    func presentErrorAlertController(error: Error, withBlock completion: @escaping () -> Void) {
        let message = error.localizedDescription
        presentDismissableAlertController(title: "Error", message: message, withBlock: {
            completion()
        })
    }
    
    /// Presents a UIAlertController with title, message, and completion block for the OK button.
    ///
    /// - parameters:
    ///     - title: The title of the UIAlertController
    ///     - message: The message of the UIAlertController
    ///     - okCompletion completion: Code to be executed when the user taps on the "OK" button
    ///
    /// - return: Returns a `@discardableResult` UIAlertController.
    @discardableResult
    func presentConfirmationAlertController(title: String?, message: String?, okCompletion completion: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            completion()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            
        }
        
        alertController.addAction(okAlertAction)
        alertController.addAction(cancelAlertAction)
        
        present(alertController, animated: true, completion: nil)
        
        return alertController
    }
    
    func resetNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.colorWithRGBHex(0x4C586F)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureNavigationView(title: String, imageName: String?, titleColor: UIColor = .white, font: UIFont? = UIFont(name: "SFUIText-Light", size: 12.0), numberOfLines:Int = 2) {
        var image: UIImage? = nil
        if let imageName = imageName {
            image = UIImage(named: imageName)?.tintImage(with: .white)
        }
        configureNavigationView(title: title, image: image, titleColor: titleColor, font: font)
    }
    
    func configureNavigationView(title: String, image: UIImage?, titleColor: UIColor = .white,
                                 font: UIFont? = UIFont(name: "SFUIText-Light", size: 12.0),numberOfLines:Int = 2) {
        // Only execute the code if there's a navigation controller
        guard self.navigationController != nil else {
            return
        }
        
        // Create a navView to add to the navigation bar
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = title
        label.numberOfLines = numberOfLines
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = titleColor
        label.font = font

        // Create the image view
        let imageView = UIImageView()
        if let image = image {
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageView.image = image
            // To maintain the image's aspect ratio:
            let imageAspect = imageView.image!.size.width/imageView.image!.size.height
            // Setting the image frame so that it's immediately before the text:
            imageView.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
            imageView.image = image.aspectFitImage(inRect: imageView.frame)
        }
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(imageView)
        
        
        navView.addConstraintsWithFormat("H:|-0-[v0]-8-[v1]-0-|", views: imageView, label)
        navView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: imageView)
        navView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: label)
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
        
        // Set navView's Back button
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    
    func configureNavigationView(title: String, logoURL: String?, titleColor: UIColor = .white, numberOfLines:Int = 2) {
        // Only execute the code if there's a navigation controller
        guard self.navigationController != nil else {
            return
        }
        
        // Create a navView to add to the navigation bar
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = title
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = numberOfLines
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = titleColor
        label.font = UIFont(name: "SFUIText-Light", size: 12.0)

        // Create the image view
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: logoURL ?? "")) { result in
            switch result {
            case .success(let response):
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = response.image
                // To maintain the image's aspect ratio:
                let imageAspect = imageView.image!.size.width/imageView.image!.size.height
                // Setting the image frame so that it's immediately before the text:
                imageView.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
                imageView.image = response.image.aspectFitImage(inRect: imageView.frame)
            case .failure(let error):
                Console.logError(error: error, message: error.localizedDescription)
                Console.logError(error: error, message: "Error loading storelogo image.")
            }
        }
//        if let image = image {
//
//        }
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(imageView)
        
        navView.addConstraintsWithFormat("H:|-0-[v0]-8-[v1]-0-|", views: imageView, label)
        navView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: imageView)
        navView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: label)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
        
        // Set navView's Back button
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    func configureNavigationViewColor(color: UIColor){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupGradient(height: CGFloat, colors:[UIColor]) ->  CAGradientLayer {
         let gradient: CAGradientLayer = CAGradientLayer()
         gradient.colors = []
         for color in colors {
                  gradient.colors?.append(color.cgColor)
         }
         gradient.locations = [0.0 , 1.0]
         gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
         gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
         gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: height)
         return gradient
    }
}
