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
        var color: NSColor = .orange // sane defaults
        
        if let colorStringFromFile = dictionaryRepresentation["color"] as? String {
            if let colorFromFile = NSColor.withCSSString(colorStringFromFile) {
                color = colorFromFile
            }
        }
                
        self.init(script: script, color: color)
    }
    
    func getCurrentOutput(handler: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let task = Process()
            let pipe = Pipe()
            
            let command = ((self.script as NSString).expandingTildeInPath) as String
            
            task.launchPath = "/bin/bash"
            task.arguments = ["-c", command]
            task.standardOutput = pipe
            
            task.launch()
            
            let handle = pipe.fileHandleForReading
            let data = handle.readDataToEndOfFile()
            handle.closeFile()
            
            task.terminate()
            
            let output: String
            
            if let stringFromData = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                output = stringFromData as String
            }
            else {
                output = ""
            }
            
            DispatchQueue.main.async {
                handler(output)
            }
        }
    }
}
