//
//  BarItemView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

protocol BarItemViewLayoutDelegate {
    func barItemViewChangedContents(barItemView: BarItemView)
}

class BarItemView : NSView, BarUpdatable, Fontable {
    let barItem: BarItem
    let label = NSTextField()
    var attributes: [String : AnyObject] = [String : AnyObject]()
    var lastOutput = ""
    
    var layoutDelegate: BarItemViewLayoutDelegate? = nil
    
    var textAlignment: NSTextAlignment = .Center {
        didSet {
            self.updateBarContents()
        }
    }
    
    var font: NSFont? = nil {
        didSet {
            if let font = font {
                attributes = [NSForegroundColorAttributeName : barItem.color,
                              NSFontAttributeName : font]
                updateBarContents()
            }
        }
    }
    
    init(barItem: BarItem) {
        self.barItem = barItem
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clearColor().CGColor
        
        self.addSubview(label)
        label.editable = false
        label.selectable = false
        label.backgroundColor = NSColor.clearColor()
        label.bordered = false
        label.bezeled = false
        label.textColor = barItem.color
        label.lineBreakMode = .ByTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layout() {
        super.layout()
        
        label.frame = self.bounds
    }
    
    override var fittingSize: NSSize {
        return label.fittingSize
    }
    
    func updateBarContents() {
        barItem.getCurrentOutput({ (output) in
            if output != self.lastOutput {
                self.lastOutput = output
                
                let attributedString = NSAttributedString(string: output, attributes: self.attributes)
                self.label.attributedStringValue = attributedString
                
                self.layoutDelegate?.barItemViewChangedContents(self)
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}