//
//  BarView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class BarView : NSView, BarUpdatable, Fontable, HeightConfigurable {
    var leftSegment: BarSegment
    var centerSegment: BarSegment
    var rightSegment: BarSegment
    
    var leftSegmentView: BarSegmentView
    var centerSegmentView: BarSegmentView
    var rightSegmentView: BarSegmentView
    
    let toolTipFormatter = NSDateFormatter()
    
    var lastUpdatedDate = NSDate() {
        didSet {
            let lastUpdatedDateString = toolTipFormatter.stringFromDate(lastUpdatedDate)
            toolTip = "Last updated at \(lastUpdatedDateString)"
        }
    }
    
    var font: NSFont? = nil {
        didSet {
            leftSegmentView.font = font
            centerSegmentView.font = font
            rightSegmentView.font = font
        }
    }
    
    var height: CGFloat = 0.0 {
        didSet {
            frame.size.height = height
        }
    }
    
    init(leftSegment: BarSegment, centerSegment: BarSegment, rightSegment: BarSegment) {
        self.leftSegment = leftSegment
        self.centerSegment = centerSegment
        self.rightSegment = rightSegment
        
        self.leftSegmentView = BarSegmentView(barSegment: leftSegment)
        self.centerSegmentView = BarSegmentView(barSegment: centerSegment)
        self.rightSegmentView = BarSegmentView(barSegment: rightSegment)
        
        toolTipFormatter.dateStyle = .NoStyle
        toolTipFormatter.timeStyle = .ShortStyle
        
        super.init(frame: CGRectMake(0, 0, 480, height))
        
        self.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        
        self.wantsLayer = true
        
        let views = [leftSegmentView, centerSegmentView, rightSegmentView]
        
        for view in views {
            self.addSubview(view)
        }
    }
    
    var backgroundColor: NSColor = NSColor.clearColor() {
        didSet {
            layer!.backgroundColor = backgroundColor.CGColor
        }
    }
    
    override func layout() {
        super.layout()
        let bounds = self.bounds
        var segmentRect = bounds
        segmentRect.size.width *= CGFloat(1.0/3.0)
        
        leftSegmentView.frame = segmentRect
        segmentRect.origin.x += segmentRect.size.width
        centerSegmentView.frame = segmentRect
        segmentRect.origin.x += segmentRect.size.width
        rightSegmentView.frame = segmentRect
    }
    
    func updateBarContents() {
        leftSegmentView.updateBarContents()
        centerSegmentView.updateBarContents()
        rightSegmentView.updateBarContents()
        
        lastUpdatedDate = NSDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}