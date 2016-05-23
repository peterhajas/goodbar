//
//  ConfigurationFileLoader.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Foundation

class ConfigurationFileLoader {
    func loadConfigurationFile(handler: (leftSegment: BarSegment, centerSegment: BarSegment, rightSegment: BarSegment) -> Void) {
        let emptyItems = [BarItem]()
        
        let configFilePath = ("~/.goodbar" as NSString).stringByExpandingTildeInPath
        if NSFileManager.defaultManager().fileExistsAtPath(configFilePath) {
            let data = NSData.init(contentsOfFile: configFilePath)!
            
            do {
                let barItems = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                
                if let barItemsDict = barItems as? [String : AnyObject] {
                    print(barItems)
                    
                    let leftSegment: BarSegment
                    let centerSegment: BarSegment
                    let rightSegment: BarSegment
                    
                    if let leftSegmentArray = barItemsDict["left"] {
                        leftSegment = BarSegment(position: .Left, arrayRepresentation: leftSegmentArray as! NSArray)
                    }
                    else {
                        leftSegment = BarSegment(position: .Left, items: emptyItems)
                    }
                    if let centerSegmentArray = barItemsDict["center"] {
                        centerSegment = BarSegment(position: .Center, arrayRepresentation: centerSegmentArray as! NSArray)
                    }
                    else {
                        centerSegment = BarSegment(position: .Center, items: emptyItems)
                    }
                    if let rightSegmentArray = barItemsDict["right"] {
                        rightSegment = BarSegment(position: .Right, arrayRepresentation: rightSegmentArray as! NSArray)
                    }
                    else {
                        rightSegment = BarSegment(position: .Right, items: emptyItems)
                    }
                    
                    handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
                }
            }
            catch {
                let leftSegment = BarSegment(position: .Left, items: emptyItems)
                let centerSegment = BarSegment(position: .Center, items: emptyItems)
                let rightSegment = BarSegment(position: .Right, items: emptyItems)
                
                handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
            }
        }
        else {
            let leftSegment = BarSegment(position: .Left, items: emptyItems)
            let centerSegment = BarSegment(position: .Center, items: emptyItems)
            let rightSegment = BarSegment(position: .Right, items: emptyItems)
            
            handler(leftSegment: leftSegment, centerSegment: centerSegment, rightSegment: rightSegment)
        }
    }
}