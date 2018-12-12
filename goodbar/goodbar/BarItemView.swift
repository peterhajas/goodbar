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

class BarItemView : NSView, BarUpdatable, BarConfigurable {
    let barItem: BarItem
    let label = NSTextField()
    var attributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key : AnyObject]()
    var lastOutput = ""
    var lastFittingSize = CGSize.zero
    
    var layoutDelegate: BarItemViewLayoutDelegate? = nil
    
    var textAlignment: NSTextAlignment = .center {
        didSet {
            self.updateBarContents()
        }
    }
    
    var barGlobalConfiguration = BarGlobalConfiguration.defaultConfiguration() {
        didSet {
            attributes = [NSAttributedString.Key.foregroundColor : barItem.color,
                          NSAttributedString.Key.font : barGlobalConfiguration.font]
            updateBarContents()
        }
    }
    
    init(barItem: BarItem) {
        self.barItem = barItem
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.wantsLayer = true
        
        self.addSubview(label)
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = false
        label.isBordered = false
        label.isBezeled = false
        label.textColor = barItem.color
        label.lineBreakMode = .byTruncatingTail
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
        barItem.getCurrentOutput(handler: { (output) in
            if output != self.lastOutput {
                self.lastOutput = output
                
                let attributedString = NSAttributedString(string: output, attributes: self.attributes)
                self.label.attributedStringValue = attributedString
                
                if self.fittingSize != self.lastFittingSize {
                    self.lastFittingSize = self.fittingSize
                    self.layoutDelegate?.barItemViewChangedContents(barItemView: self)
                }
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
