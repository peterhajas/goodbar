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
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        configFileLoader.loadConfigurationFile { (leftSegment, centerSegment, rightSegment) in
            self.barView = BarView(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
            self.window.contentView = self.barView
            
            self.barView?.updateBarContents()
        }
    }
}
