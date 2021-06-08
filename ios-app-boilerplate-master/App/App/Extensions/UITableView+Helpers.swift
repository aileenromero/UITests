//
//  UITableView+Helpers.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 09/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Shows an empty state for tableview using a UILabel at the center of the tableview
    ///
    /// - parameters:
    ///     - isEmpty: Set to `true` to show empty state label. Set to `false` to to reset backgroundView.
    ///     - emptyMessage: String message to be set on the UILabel
    ///
    /// - Important: After running this code, Run this code again with isEmpty = false to reset the backgroundView when tableview is not empty.
    func setEmptyStateBackground(isEmpty: Bool, emptyMessage: String?) {
        guard isEmpty else {
            self.backgroundView = nil
            return
        }
        
        let labelFrame = CGRect(x: self.bounds.minX, y: self.bounds.height/2, width: self.bounds.width, height: self.bounds.height)
        let emptyLabel = UILabel(frame: labelFrame)
        emptyLabel.text = emptyMessage
        emptyLabel.textColor = UIColor.black
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        self.backgroundView = emptyLabel
    }
    
}
