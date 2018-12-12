//
//  BarSegment.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

enum BarSegmentPosition {
    case Left
    case Center
    case Right
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .Left:
            return .left
        case .Center:
            return .center
        case .Right:
            return .right
        }
    }
}

struct BarSegment {
    let position: BarSegmentPosition
    let items: [BarItem]
    
    init(position: BarSegmentPosition, items: [BarItem]) {
        self.position = position
        self.items = items
    }
    
    init(position: BarSegmentPosition, arrayRepresentation: NSArray) {
        var items = [BarItem]()
        
        for dictionaryRepresentation in arrayRepresentation {
            let item = BarItem(dictionaryRepresentation: dictionaryRepresentation as! NSDictionary)
            items.append(item)
        }
        
        self.init(position: position, items: items)
    }
}
