//
//  BarItem.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

struct BarItem {
    let script: String
    let color: NSColor
    
    init(script: String, color: NSColor) {
        self.script = script
        self.color = color
    }
    
    init(dictionaryRepresentation: NSDictionary) {
        let script = dictionaryRepresentation["script"] as! String
        let color = NSColor.orangeColor()
        
        self.init(script: script, color: color)
    }
    
    func currentOutput() -> String {
        let task = NSTask()
        let pipe = NSPipe()
        
        let command = ((self.script as NSString).stringByExpandingTildeInPath) as String
        
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        task.standardOutput = pipe
        
        task.launch()
        
        sleep(1)
        task.terminate()
        
        // Waiting seems busted right now...
//        task.waitUntilExit()
        
        let handle = pipe.fileHandleForReading
        let data = handle.readDataToEndOfFile()
        
        if let stringFromData = NSString(data: data, encoding: NSUTF8StringEncoding) {
            return stringFromData as String
        }
        else {
            return ""
        }
    }
}
