//
//  BarView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class BarView : NSView, BarUpdatable, BarConfigurable {
    var leftSegment: BarSegment
    var centerSegment: BarSegment
    var rightSegment: BarSegment
    
    var leftSegmentView: BarSegmentView
    var centerSegmentView: BarSegmentView
    var rightSegmentView: BarSegmentView
    
    let toolTipFormatter = DateFormatter()
    
    var lastUpdatedDate = Date() {
        didSet {
            let lastUpdatedDateString = toolTipFormatter.string(from: lastUpdatedDate)
            toolTip = "Last updated at \(lastUpdatedDateString)"
        }
    }
    
    var barGlobalConfiguration = BarGlobalConfiguration.defaultConfiguration() {
        didSet {
            backgroundColor = barGlobalConfiguration.backgroundColor
            frame.size.height = barGlobalConfiguration.height
            
            leftSegmentView.barGlobalConfiguration = barGlobalConfiguration
            centerSegmentView.barGlobalConfiguration = barGlobalConfiguration
            rightSegmentView.barGlobalConfiguration = barGlobalConfiguration
        }
    }
    
    init(leftSegment: BarSegment, centerSegment: BarSegment, rightSegment: BarSegment) {
        self.leftSegment = leftSegment
        self.centerSegment = centerSegment
        self.rightSegment = rightSegment
        
        self.leftSegmentView = BarSegmentView(barSegment: leftSegment)
        self.centerSegmentView = BarSegmentView(barSegment: centerSegment)
        self.rightSegmentView = BarSegmentView(barSegment: rightSegment)
        
        toolTipFormatter.dateStyle = .none
        toolTipFormatter.timeStyle = .short
        
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 0))
        
        self.autoresizingMask = [.width, .height]
        
        self.wantsLayer = true
        
        let views = [leftSegmentView, centerSegmentView, rightSegmentView]
        
        for view in views {
            self.addSubview(view)
        }
    }
    
    var backgroundColor: NSColor = .clear {
        didSet {
            layer!.backgroundColor = backgroundColor.cgColor
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
        
        lastUpdatedDate = Date()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
