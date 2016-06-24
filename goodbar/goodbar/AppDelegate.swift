//
//  AppDelegate.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    let configFileLoader = ConfigurationFileLoader()
    var barView: BarView? = nil
    var updateTimer: NSTimer? = nil
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        updateTimer = NSTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.update), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(updateTimer!, forMode: NSRunLoopCommonModes)
        
        configFileLoader.loadConfigurationFile { (leftSegment, centerSegment, rightSegment, height, backgroundColor, font) in
            self.barView = BarView(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
            self.barView!.backgroundColor = backgroundColor
            self.barView!.font = font
            self.window.contentView = self.barView
            self.update()
        }
    }
    
    func update() {
        self.barView?.updateBarContents()
    }
}
