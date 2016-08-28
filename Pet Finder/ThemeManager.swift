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
        
        // 4 - Customize the navigation back bar indicator
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        // UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMask")
        // UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        // 5 - Apply tab bar background images, background colors, and secondary theme colors
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        
        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.imageWithRenderingMode(.AlwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        
        // 6 - Apply the theme to the segmented control (removes rounded corners using UIEdgeInsets)
        let controlBackground = UIImage(named: "controlBackground")?
            .imageWithRenderingMode(.AlwaysTemplate)
            .resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
            .imageWithRenderingMode(.AlwaysTemplate)
            .resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        
        UISegmentedControl.appearance().setBackgroundImage(controlBackground, forState: .Normal,
                                                           barMetrics: .Default)
        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, forState: .Selected,
                                                           barMetrics: .Default)
        
        // 7 - Apply theme to the stepper 
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Highlighted)
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), forState: .Normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), forState: .Normal)
        
        // 7 - Apply theme to the slider
        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), forState: .Normal)
        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
            .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)),
                                                   forState: .Normal)
        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
            .imageWithRenderingMode(.AlwaysTemplate)
            .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)),
                                                   forState: .Normal)
        
        // 8 - Apply theme to the switch
        UISwitch.appearance().onTintColor = theme.mainColor.colorWithAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainColor
        
        
    }
}