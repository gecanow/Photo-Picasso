//
//  DrawView.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/17/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class DrawView: UIImageView {
    
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
        
        var cgpointArr = [CGPoint]()
        if points.count > 0 {
            context?.beginPath()
            for line in points {
                
                context?.setLineWidth(CGFloat(line.thickness))
                
                if line.isEraser {
                    context?.setStrokeColor((self.backgroundColor?.cgColor)!)
                } else {
                    context?.setStrokeColor(line.color.cgColor)
                }
                
                if line.startsATurn { cgpointArr = [CGPoint]() }
                    
                cgpointArr.append(line.start)
                cgpointArr.append(line.end)
                
                
                
                context?.addLines(between: cgpointArr)
                context?.strokePath()
                line.drawn = true
            }
        }
    }
    
    func drawLineFrom(line: Line) {//fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        // 2
        context?.move(to: line.start)
        context?.addLine(to: line.end)
        
        // 3
        context?.setLineCap(.round)
        context?.setLineWidth(CGFloat(line.thickness))
        
        if line.isEraser {
            context?.setStrokeColor((self.backgroundColor?.cgColor)!)
        } else {
            context?.setStrokeColor(line.color.cgColor)
        }
        
        context?.setBlendMode(.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.alpha = 1.0//opacity
        UIGraphicsEndImageContext()
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
