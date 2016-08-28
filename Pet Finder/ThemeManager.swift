//
//  ThemeManager.swift
//  Pet Finder
//
//  Created by Daniel J Janiak on 8/28/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit


struct ThemeManager {
    
    static func currentTheme() -> Theme {
        if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey(SelectedThemeKey)?.integerValue {
            return Theme(rawValue: storedTheme)! // Note: the rawValue initializer is failable
        } else {
            return .Default
        }
    }
    
    static func applyTheme(theme: Theme) {
        
        // 1
        NSUserDefaults.standardUserDefaults().setValue(theme.rawValue, forKey: SelectedThemeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // 2 - UIWindow inherits from UIView, so changing the tintColor applies throughout the app
        let sharedApplication = UIApplication.sharedApplication()
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        // 3 - extend the theme-specific visual modifications to the navigation bar
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, forBarMetrics: .Default)
    }
}