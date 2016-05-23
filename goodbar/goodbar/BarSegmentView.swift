//
//  BarSegmentView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class BarSegmentView : NSView, BarUpdatable {
    let barSegment: BarSegment
    var barItemViews = [BarItemView]()
    
    init(barSegment: BarSegment) {
        self.barSegment = barSegment
        
        for item in barSegment.items {
            let barItemView = BarItemView(barItem: item)
            barItemViews.append(barItemView)
        }
        
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for view in barItemViews {
            self.addSubview(view)
        }
    }
    
    override func layout() {
        super.layout()
        var runningX: CGFloat = 0
        for view in barItemViews {
            let fittingSize = view.fittingSize
            let viewFrame = CGRectMake(runningX, 0, fittingSize.width, self.bounds.size.height)
            view.frame = viewFrame
            
            runningX = view.bounds.size.width
        }
    }
    
    func updateBarContents() {
        for view in barItemViews {
            view.updateBarContents()
        }
        
        self.needsLayout = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}