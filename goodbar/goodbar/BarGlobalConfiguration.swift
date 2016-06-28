//
//  BarGlobalConfiguration.swift
//  goodbar
//
//  Created by Peter Hajas on 6/28/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import AppKit

struct BarGlobalConfiguration {
    static let defaultBackgroundColor = NSColor.withCSSString("#2d2d2d")!
    static let defaultFont = NSFont(name: "Menlo", size: 14.0)!
    static let defaultHeight: CGFloat = 23
    static let defaultVerticalOffset: CGFloat = 0
    static let defaultInsetPercent = 0.0
    
    let backgroundColor: NSColor
    let font: NSFont
    let height: CGFloat
    let verticalOffset: CGFloat
    let insetPercent: Double
    
    static func defaultConfiguration() -> BarGlobalConfiguration {
        return BarGlobalConfiguration(backgroundColor: defaultBackgroundColor, font: defaultFont, height: defaultHeight, verticalOffset: defaultVerticalOffset, insetPercent: defaultInsetPercent)
    }
}
