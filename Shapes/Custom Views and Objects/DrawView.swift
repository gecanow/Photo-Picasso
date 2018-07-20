//
//  DrawView.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/17/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var points = [Line]()
    
    //=====================================================
    // INIT
    //=====================================================
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //=====================================================
    // Overriden function draw
    //=====================================================
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        if points.count > 0 {
            context?.beginPath()
            for line in points {
                
                context?.setLineWidth(CGFloat(line.thickness))
                context?.setLineCap(.round)
                context?.setBlendMode(.normal)
                context?.setAlpha(CGFloat(line.opacity))
                
                if line.isEraser {
                    context?.setStrokeColor((self.backgroundColor?.cgColor)!)
                } else {
                    context?.setStrokeColor(line.color.cgColor)
                }
                
                context?.move(to: line.start)
                context?.addLine(to: line.end)
                context?.strokePath()
                line.drawn = true
            }
        }
    }
    
    //=====================================================
    // Undoes the last move by finding the last start 
    // point and then removing everything after it
    //=====================================================
    func undoLastMove() {
        var latestStart = 0
        for index in 0..<points.count {
            if points[index].startsATurn {
                latestStart = index
            }
        }
        points = Array(points.prefix(latestStart))
        self.setNeedsDisplay()
    }

}
