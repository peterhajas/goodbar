//
//  Window.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class Window : NSWindow {
    private func updateSizeAndScreen() {
        let screenToUse = NSScreen.screens()![0]
        
        let screenRect = screenToUse.visibleFrame
        
        // 4 is a fudge factor
        let yPosition = screenRect.size.height - BarGeometry.height + 4
        
        let windowRect = CGRectMake(0, yPosition, screenRect.width, BarGeometry.height)
        
        self.minSize = windowRect.size
        self.maxSize = windowRect.size
        
        self.setFrame(windowRect, display: true)
    }
    
    override func constrainFrameRect(frameRect: NSRect, toScreen screen: NSScreen?) -> NSRect {
        return frameRect
    }
    
    private func commonInit() {
        let cgLevelKey = CGWindowLevelKey.BackstopMenuLevelKey
        let cgLevel = CGWindowLevelForKey(cgLevelKey)
        let level = Int(cgLevel)
        
        self.level = level
        self.collectionBehavior = [.Default, .Transient]
        
        updateSizeAndScreen()
    }
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}