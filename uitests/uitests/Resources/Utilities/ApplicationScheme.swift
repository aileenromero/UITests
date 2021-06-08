//
//  ApplicationScheme.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 03/07/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialColorScheme

class ApplicationScheme: NSObject {
    
    private static var singleton = ApplicationScheme()
    
    static var shared: ApplicationScheme {
        return singleton
    }
    
    public let typographyScheme: MDCTypographyScheming = {
        let scheme = MDCTypographyScheme()
        scheme.headline1 = UIFont.light(size: Styles.Fonts.headline1)
        scheme.headline2 = UIFont.light(size: Styles.Fonts.headline2)
        scheme.headline3 = UIFont.regular(size: Styles.Fonts.headline3)
        scheme.headline4 = UIFont.regular(size: Styles.Fonts.headline4)
        scheme.headline5 = UIFont.regular(size: Styles.Fonts.headline5)
        scheme.headline6 = UIFont.semibold(size: Styles.Fonts.headline6)
        scheme.subtitle1 = UIFont.regular(size: Styles.Fonts.subtitle1)
        scheme.subtitle2 = UIFont.regular(size: Styles.Fonts.subtitle2)
        scheme.body1 = UIFont.regular(size: Styles.Fonts.body1)
        scheme.body2 = UIFont.regular(size: Styles.Fonts.body2)
        scheme.button = UIFont.semibold(size: Styles.Fonts.button)
        scheme.caption = UIFont.regular(size: Styles.Fonts.caption)
        scheme.overline = UIFont.regular(size: Styles.Fonts.overline)
        return scheme
    }()
    
    public let colorScheme: MDCSemanticColorScheme = {
        let scheme = MDCSemanticColorScheme()
        scheme.primaryColor = UIColor.primaryColor
        scheme.secondaryColor = UIColor.secondaryColor
        // No secondaryColorVariant...
        scheme.backgroundColor = UIColor.backgroundColor
        scheme.surfaceColor = UIColor.surfaceColor
        scheme.errorColor = UIColor.errorColor
        scheme.onPrimaryColor = UIColor.onPrimaryColor
        // No onPrimaryColorVariant...
        scheme.onSecondaryColor = UIColor.onSecondaryColor
        // No onSecondaryColorVariant...
        scheme.onBackgroundColor = UIColor.onBackgroundColor
        scheme.onSurfaceColor = UIColor.onSurfaceColor
        // No onErrorColor...
        return scheme
    }()
    
    public let lightColorScheme: MDCSemanticColorScheme = {
        let scheme = MDCSemanticColorScheme()
        scheme.primaryColor = UIColor.primaryColor
        scheme.primaryColorVariant = UIColor.primaryColorLightVariant
        scheme.secondaryColor = UIColor.secondaryColor
        // No secondaryColorVariant...
        scheme.backgroundColor = UIColor.backgroundColor
        scheme.surfaceColor = UIColor.surfaceColor
        scheme.errorColor = UIColor.errorColor
        scheme.onPrimaryColor = UIColor.onPrimaryColor
        // No onPrimaryColorVariant...
        scheme.onSecondaryColor = UIColor.onSecondaryColor
        // No onSecondaryColorVariant...
        scheme.onBackgroundColor = UIColor.onBackgroundColor
        scheme.onSurfaceColor = UIColor.onSurfaceColor
        // No onErrorColor...
        return scheme
    }()
    
    public let darkColorScheme: MDCSemanticColorScheme = {
        let scheme = MDCSemanticColorScheme()
        scheme.primaryColor = UIColor.primaryColor
        scheme.primaryColorVariant = UIColor.primaryColorDarkVariant
        scheme.secondaryColor = UIColor.secondaryColor
        // No secondaryColorVariant...
        scheme.backgroundColor = UIColor.backgroundColor
        scheme.surfaceColor = UIColor.surfaceColor
        scheme.errorColor = UIColor.errorColor
        scheme.onPrimaryColor = UIColor.onPrimaryColor
        // No onPrimaryColorVariant...
        scheme.onSecondaryColor = UIColor.onSecondaryColor
        // No onSecondaryColorVariant...
        scheme.onBackgroundColor = UIColor.onBackgroundColor
        scheme.onSurfaceColor = UIColor.onSurfaceColor
        // No onErrorColor...
        return scheme
    }()
    
    
    
}
