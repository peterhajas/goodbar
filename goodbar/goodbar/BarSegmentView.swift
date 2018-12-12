//
//  BarSegmentView.swift
//  goodbar
//
//  Created by Peter Hajas on 5/22/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import Cocoa

class BarSegmentView : NSView, BarUpdatable, BarConfigurable, BarItemViewLayoutDelegate {
    let barSegment: BarSegment
    var barItemViews = [BarItemView]()
    
    var barGlobalConfiguration = BarGlobalConfiguration.defaultConfiguration() {
        didSet {
            for view in barItemViews {
                view.barGlobalConfiguration = barGlobalConfiguration
            }
        }
    }
    
    init(barSegment: BarSegment) {
        self.barSegment = barSegment
        
        for item in barSegment.items {
            let barItemView = BarItemView(barItem: item)
            barItemViews.append(barItemView)
        }
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for view in barItemViews {
            self.addSubview(view)
            view.layoutDelegate = self
        }
    }
    
    func barItemViewCanTakeUpRemainingWidth(itemView: BarItemView) -> Bool {
        switch barSegment.position {
        case .Left:
            return barItemViews.last == itemView
        case .Center:
            return barItemViews.count == 1
        case .Right:
            return barItemViews.first == itemView
        }
    }
    
    override func layout() {
        super.layout()
        var totalItemWidth: CGFloat = 0
        
        for view in barItemViews {
            let fittingSize = view.fittingSize
            let viewFrame = CGRect(x: totalItemWidth, y: 0, width: fittingSize.width, height: self.bounds.size.height)
            view.frame = viewFrame
            totalItemWidth += viewFrame.size.width
        }
        
        let widthDifference = bounds.size.width - totalItemWidth
        var xOffset: CGFloat = 0
        
        if barSegment.position == .Center {
            // We need to center all the views
            
            // Shift by the difference in widths / 2
            
            xOffset = widthDifference / 2
        }
        else if barSegment.position == .Right {
            // We need to right-justify every view
            
            // Shift by the difference in widths
            
            xOffset = widthDifference
        }
        
        if xOffset != 0 {
            for view in barItemViews {
                var viewFrame = view.frame
                viewFrame.origin.x += xOffset
                
                if barItemViewCanTakeUpRemainingWidth(itemView: view) {
                    viewFrame.size.width += widthDifference
                }
                
                view.frame = viewFrame
            }
        }
    }
    
    func updateBarContents() {
        for view in barItemViews {
            view.updateBarContents()
        }
    }
    
    func barItemViewChangedContents(barItemView: BarItemView) {
        needsLayout = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
