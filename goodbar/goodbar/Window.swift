//
//  Window.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class Window : NSWindow, BarConfigurable {
    var barGlobalConfiguration = BarGlobalConfiguration.defaultConfiguration() {
        didSet {
            updateSizeAndScreen()
        }
    }
    
    private func updateSizeAndScreen() {
        guard let screenToUse = NSScreen.screens.first else { return }
        
        let screenRect = screenToUse.frame
        
        let height = barGlobalConfiguration.height
        let edgeOffset = barGlobalConfiguration.edgeOffset
        let insetPercent = barGlobalConfiguration.insetPercent
        
        let xPosition = CGFloat(insetPercent) * screenRect.width
        let yPosition = screenRect.size.height - (height + edgeOffset)
        let width = screenRect.width * CGFloat(1 - 2 * insetPercent)
        
        let windowRect = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        
        self.minSize = windowRect.size
        self.maxSize = windowRect.size
        
        self.setFrame(windowRect, display: true)
    }
    
    override func constrainFrameRect(_ frameRect: NSRect, to screen: NSScreen?) -> NSRect {
        return frameRect
    }
    
    private func commonInit() {
        let cgLevelKey = CGWindowLevelKey.backstopMenu
        let cgLevel = CGWindowLevelForKey(cgLevelKey)
        
        self.level = NSWindow.Level(rawValue: Int(cgLevel))
        collectionBehavior = [.transient]
        
        updateSizeAndScreen()
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        commonInit()
    }
}
