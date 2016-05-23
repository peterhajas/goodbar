//
//  BarItemView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class BarItemView : NSView, BarUpdatable {
    let barItem: BarItem
    let label = NSTextField()
    
    init(barItem: BarItem) {
        self.barItem = barItem
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        label.editable = false
        label.selectable = false
    }
    
    override func layout() {
        super.layout()
        
        label.frame = self.bounds
    }
    
    override var fittingSize: NSSize {
        return label.fittingSize
    }
    
    func updateBarContents() {
        label.stringValue = self.barItem.currentOutput()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}