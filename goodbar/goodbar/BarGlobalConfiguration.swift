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
    static let defaultEdgeOffset: CGFloat = 20
    static let defaultInsetPercent = 0.0
    
    let backgroundColor: NSColor
    let font: NSFont
    let height: CGFloat
    let edgeOffset: CGFloat
    let insetPercent: Double
    
    static func defaultConfiguration() -> BarGlobalConfiguration {
        return BarGlobalConfiguration(backgroundColor: defaultBackgroundColor, font: defaultFont, height: defaultHeight, edgeOffset: defaultEdgeOffset, insetPercent: defaultInsetPercent)
    }
    
    static func withPotentiallyNilOptions(backgroundColor: NSColor?, fontName: String?, fontSize: CGFloat?, height: CGFloat?, edgeOffset: CGFloat?, insetPercent: Double?) -> BarGlobalConfiguration {
        
        var actualBackgroundColor = defaultBackgroundColor
        var actualFont = defaultFont
        var actualHeight = defaultHeight
        var actualEdgeOffset = defaultEdgeOffset
        var actualInsetPercent = defaultInsetPercent
        
        if backgroundColor != nil {
            actualBackgroundColor = backgroundColor!
        }
        if fontName != nil {
            if let font = NSFont(name: fontName!, size: actualFont.pointSize) {
                actualFont = font
            }
        }
        if fontSize != nil {
            if let font = NSFont(name: actualFont.fontName, size: fontSize!) {
                actualFont = font
            }
        }
        if height != nil {
            actualHeight = height!
        }
        if edgeOffset != nil {
            actualEdgeOffset = edgeOffset!
        }
        if insetPercent != nil {
            actualInsetPercent = insetPercent!
        }
        
        let configuration = BarGlobalConfiguration(backgroundColor: actualBackgroundColor, font: actualFont, height: actualHeight, edgeOffset: actualEdgeOffset, insetPercent: actualInsetPercent)
        
        return configuration
    }
}
