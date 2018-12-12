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
    
    func substring(in range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
}

extension NSColor {
    class func withCSSString(_ cssString: String) -> NSColor? {
        if cssString.contains("#") {
            return NSColor.withCSSString(cssString.replacingOccurrences(of: "#", with: ""))
        }
        
        // Expand short CSS string to long
        if cssString.count == 3 {
            let red = cssString.substring(in: NSRange(location: 0, length: 1))
            let green = cssString.substring(in: NSRange(location: 1, length: 1))
            let blue = cssString.substring(in: NSRange(location: 2, length: 1))

            let compositeString = red + red + green + green + blue + blue
            return NSColor.withCSSString(compositeString)
        }
        
        let redString = cssString.substring(in: NSRange(location: 0, length: 2))
        let greenString = cssString.substring(in: NSRange(location: 2, length: 2))
        let blueString = cssString.substring(in: NSRange(location: 4, length: 2))
        
        let red255 = redString.valueIn0To255RangeForBase16()
        let green255 = greenString.valueIn0To255RangeForBase16()
        let blue255 = blueString.valueIn0To255RangeForBase16()

        let total: CGFloat = 255

        let redComponent = CGFloat(red255) / total
        let greenComponent = CGFloat(green255) / total
        let blueComponent = CGFloat(blue255) / total
        
        return NSColor(calibratedRed: redComponent, green: greenComponent, blue: blueComponent, alpha: 1.0)
        
//        var string = cssString
//
//        // Expand short CSS to long
//        if string.count == 3 {
//            let firstCharacter = String(string.startIndex)
//            let secondCharacter = String(string.index(after: string.startIndex))
//            let thirdCharacter = String(string[2])
//
//            string = firstCharacter + firstCharacter + secondCharacter + secondCharacter + thirdCharacter + thirdCharacter
//        }
//
//        if string.count == 6 {
//            // Now that we have our 6 characters, get the substrings
//
//            let redStartIndex = string.startIndex
//            let greenStartIndex = string.index(after: redStartIndex)
//            let greenStartIndex = redStartIndex.successor().successor()
//            let blueStartIndex = greenStartIndex.successor().successor()
//
//            let redString = string.substringWithRange(redStartIndex..<greenStartIndex)
//            let greenString = string.substringWithRange(greenStartIndex..<blueStartIndex)
//            let blueString = string.substringWithRange(blueStartIndex..<string.endIndex)
//
//            let red255 = redString.valueIn0To255RangeForBase16()
//            let green255 = greenString.valueIn0To255RangeForBase16()
//            let blue255 = blueString.valueIn0To255RangeForBase16()
//
//            let total: CGFloat = 255
//
//            let redComponent = CGFloat(red255) / total
//            let greenComponent = CGFloat(green255) / total
//            let blueComponent = CGFloat(blue255) / total
//
//        }
//
//        return nil
//    }
    }
}
