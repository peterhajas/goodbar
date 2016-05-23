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
        
        let windowRect = CGRectMake(0, 0, screenRect.width, BarGeometry.height)
        
        self.setFrameOrigin(CGPointMake(0, 0))
        self.minSize = windowRect.size
        self.maxSize = windowRect.size
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