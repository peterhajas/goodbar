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
        
        var constraints = [NSLayoutConstraint]()
        var anchorForLeftAlignment = self.leftAnchor
        
        for view in barItemViews {
            self.addSubview(view)
            
            constraints.append(view.leftAnchor.constraintEqualToAnchor(anchorForLeftAlignment))
            anchorForLeftAlignment = view.rightAnchor
        }
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func updateBarContents() {
        for view in barItemViews {
            view.updateBarContents()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}