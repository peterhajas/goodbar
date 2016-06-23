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
        
        let yPosition = screenRect.size.height - BarGeometry.height
        
        let windowRect = CGRectMake(0, yPosition, screenRect.width, BarGeometry.height)
        
        self.minSize = windowRect.size
        self.maxSize = windowRect.size
        
        self.setFrame(windowRect, display: true)
    }
    
    override func constrainFrameRect(frameRect: NSRect, toScreen screen: NSScreen?) -> NSRect {
        return frameRect
    }
    
    private func commonInit() {
        self.level = 1000000000
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