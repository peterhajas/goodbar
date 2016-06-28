//
//  ConfigurationFileLoader.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class ConfigurationFileLoader {
    func loadConfigurationFile(handler: (leftSegment: BarSegment, centerSegment: BarSegment, rightSegment: BarSegment, barGlobalConfiguration: BarGlobalConfiguration) -> Void) {
        let emptyItems = [BarItem]()
        
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
                    
                    var backgroundColor: NSColor? = nil
                    var height: CGFloat? = nil
                    var fontName: String? = nil
                    var fontSize: CGFloat? = nil
                    
                    if let specifiedBackgroundColorString = configDict["backgroundColor"] {
                        if let colorForCSS = NSColor.withCSSString(specifiedBackgroundColorString as! String) {
                            backgroundColor = colorForCSS
                        }
                    }
                    
                    if let specifiedHeightInt = configDict["height"] as? Int {
                        height = CGFloat(specifiedHeightInt)
                    }
                    
                    if let specifiedFontNameString = configDict["fontName"] as? String {
                        fontName = specifiedFontNameString
                    }
                    
                    if let specifiedFontSize = configDict["fontSize"] as? Int {
                        fontSize = CGFloat(specifiedFontSize)
                    }
                    
                    let barGlobalConfiguration = BarGlobalConfiguration.withPotentiallyNilOptions(backgroundColor, fontName: fontName, fontSize: fontSize, height: height, verticalOffset: 0.0, insetPercent: 0.0)
                    
                    handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, barGlobalConfiguration: barGlobalConfiguration)
                }
            }
            catch {
                let leftSegment = BarSegment(position: .Left, items: emptyItems)
                let centerSegment = BarSegment(position: .Center, items: emptyItems)
                let rightSegment = BarSegment(position: .Right, items: emptyItems)
                
                handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, barGlobalConfiguration: BarGlobalConfiguration.defaultConfiguration())
            }
        }
        else {
            let leftSegment = BarSegment(position: .Left, items: emptyItems)
            let centerSegment = BarSegment(position: .Center, items: emptyItems)
            let rightSegment = BarSegment(position: .Right, items: emptyItems)
            
            handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment, barGlobalConfiguration: BarGlobalConfiguration.defaultConfiguration())
        }
    }
}