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
}
