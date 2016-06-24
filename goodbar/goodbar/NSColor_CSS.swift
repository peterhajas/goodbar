//
//  NSColor_CSS.swift
//  goodbar
//
//  Created by Peter Hajas on 6/23/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

extension String {
    func valueIn0To255RangeForBase16() -> UInt {
        return strtoul(self, nil, 16) as UInt
    }
}

extension NSColor {
    class func withCSSString(cssString: String) -> NSColor? {
        var string = cssString
        
        // Trim leading #
        if string.characters.first! == "#" {
            string = string.substringFromIndex(string.startIndex.successor())
        }
        
        // Expand short CSS to long
        if string.characters.count == 3 {
            let firstCharacter = String(string.characters.first!)
            let secondCharacter = String(string.characters[string.startIndex.successor()])
            let thirdCharacter = String(string.characters[string.startIndex.successor().successor()])
            
            string = firstCharacter + firstCharacter + secondCharacter + secondCharacter + thirdCharacter + thirdCharacter
        }
        
        if string.characters.count == 6 {
            // Now that we have our 6 characters, get the substrings
            
            let redStartIndex = string.startIndex
            let greenStartIndex = redStartIndex.successor().successor()
            let blueStartIndex = greenStartIndex.successor().successor()
            
            let redString = string.substringWithRange(redStartIndex..<greenStartIndex)
            let greenString = string.substringWithRange(greenStartIndex..<blueStartIndex)
            let blueString = string.substringWithRange(blueStartIndex..<string.endIndex)
            
            let red255 = redString.valueIn0To255RangeForBase16()
            let green255 = greenString.valueIn0To255RangeForBase16()
            let blue255 = blueString.valueIn0To255RangeForBase16()
            
            let total: CGFloat = 255
            
            let redComponent = CGFloat(red255) / total
            let greenComponent = CGFloat(green255) / total
            let blueComponent = CGFloat(blue255) / total
            
            return NSColor(calibratedRed: redComponent, green: greenComponent, blue: blueComponent, alpha: 1.0)
        }
        
        return nil
    }
}
