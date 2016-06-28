//
//  ConfigurationFileLoader.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class ConfigurationFileLoader {
    func loadConfigurationFile(handler: (leftSegment: BarSegment, centerSegment: BarSegment, rightSegment: BarSegment, height: CGFloat, backgroundColor: NSColor, font: NSFont) -> Void) {
        let emptyItems = [BarItem]()
        let defaultHeight: CGFloat = 23
        let defaultBackgroundColor = NSColor.withCSSString("#2d2d2d")!
        let defaultFont = NSFont(name: "Menlo", size: 14)!
        
        let configFilePath = ("~/.goodbar" as NSString).stringByExpandingTildeInPath
        if NSFileManager.defaultManager().fileExistsAtPath(configFilePath) {
            let data = NSData.init(contentsOfFile: configFilePath)!
            
            do {
                let config = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                
                if let configDict = config as? [String : AnyObject] {
                    let leftSegment: BarSegment
                    let centerSegment: BarSegment
                    let rightSegment: BarSegment
                    
                    if let leftSegmentArray = configDict["left"] {
                        leftSegment = BarSegment(position: .Left, arrayRepresentation: leftSegmentArray as! NSArray)
                    }
                    else {
                        leftSegment = BarSegment(position: .Left, items: emptyItems)
                    }
                    if let centerSegmentArray = configDict["center"] {
                        centerSegment = BarSegment(position: .Center, arrayRepresentation: centerSegmentArray as! NSArray)
                    }
                    else {
                        centerSegment = BarSegment(position: .Center, items: emptyItems)
                    }
                    if let rightSegmentArray = configDict["right"] {
                        rightSegment = BarSegment(position: .Right, arrayRepresentation: rightSegmentArray as! NSArray)
                    }
                    else {
                        rightSegment = BarSegment(position: .Right, items: emptyItems)
                    }
                    
                    // Optional Global Options
                    
                    var height = defaultHeight
                    var backgroundColor = defaultBackgroundColor
                    var font = defaultFont
                    
                    if let specifiedHeightInt = configDict["height"] {
                        height = CGFloat(specifiedHeightInt as! Int)
                    }
                    
                    if let specifiedBackgroundColorString = configDict["backgroundColor"] {
                        if let colorForCSS = NSColor.withCSSString(specifiedBackgroundColorString as! String) {
                            backgroundColor = colorForCSS
                        }
                    }
                    
                    handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, height: height, backgroundColor: backgroundColor, font: font)
                }
            }
            catch {
                let leftSegment = BarSegment(position: .Left, items: emptyItems)
                let centerSegment = BarSegment(position: .Center, items: emptyItems)
                let rightSegment = BarSegment(position: .Right, items: emptyItems)
                
                handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, height: defaultHeight, backgroundColor: defaultBackgroundColor, font: defaultFont)
            }
        }
        else {
            let leftSegment = BarSegment(position: .Left, items: emptyItems)
            let centerSegment = BarSegment(position: .Center, items: emptyItems)
            let rightSegment = BarSegment(position: .Right, items: emptyItems)
            
            handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, height: defaultHeight, backgroundColor: defaultBackgroundColor, font: defaultFont)
        }
    }
}