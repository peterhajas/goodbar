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
        var color = NSColor.orangeColor() // sane defaults
        
        if let colorStringFromFile = dictionaryRepresentation["color"] as? String {
            if let colorFromFile = NSColor.withCSSString(colorStringFromFile) {
                color = colorFromFile
            }
        }
                
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
        
        let handle = pipe.fileHandleForReading
        let data = handle.readDataToEndOfFile()
        handle.closeFile()
        
        task.terminate()
        
        if let stringFromData = NSString(data: data, encoding: NSUTF8StringEncoding) {
            return stringFromData as String
        }
        else {
            return ""
        }
    }
}
