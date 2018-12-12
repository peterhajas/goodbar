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
    var updateTimer: Timer? = nil
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        updateTimer = Timer(timeInterval: 1, target: self, selector: #selector(AppDelegate.update), userInfo: nil, repeats: true)
        RunLoop.main.add(updateTimer!, forMode: RunLoop.Mode.common)
        
        configFileLoader.loadConfigurationFile { (leftSegment, centerSegment, rightSegment, barGlobalConfiguration) in
            self.barView = BarView(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
            self.barView!.barGlobalConfiguration = barGlobalConfiguration
            (self.window as! Window).barGlobalConfiguration = barGlobalConfiguration
            self.window.contentView = self.barView
            self.update()
        }
    }
    
    @objc func update() {
        self.barView?.updateBarContents()
    }
}
