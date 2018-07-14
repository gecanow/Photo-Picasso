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
            }
        }
    }
    
    func imageByDrawingCircle(on image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: image.size.width, height: image.size.height), false, 0.0)
        
        // draw original image into the context
        image.draw(at: CGPoint.zero)
        
        // get the context for CoreGraphics
        let ctx = UIGraphicsGetCurrentContext()!
        
        // set stroking color and draw circle
        ctx.setStrokeColor(UIColor.red.cgColor)
        
        // make circle rect 5 px from border
        var circleRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        circleRect = circleRect.insetBy(dx: 5, dy: 5)
        
        // draw circle
        ctx.strokeEllipse(in: circleRect)
        
        // make image out of bitmap context
        let retImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // free the context
        UIGraphicsEndImageContext()
        
        return retImage;
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
