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
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        window.level = 1000000000
        window.collectionBehavior = [.Default, .Transient]
        
        configFileLoader.loadConfigurationFile { (leftSegment, centerSegment, rightSegment) in
            //
        }
    }
}
