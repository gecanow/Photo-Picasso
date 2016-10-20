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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        if points.count > 0 {
            context?.beginPath()
            for line in points {
                context?.setLineWidth(CGFloat(line.thickness))
                
                if line.isEraser {
                    context?.setStrokeColor((self.backgroundColor?.cgColor)!)
                } else {
                    context?.setStrokeColor(line.color.cgColor)
                }
                context?.move(to: line.start)
                context?.addLine(to: line.end)
                context?.strokePath()
            }
        }
    }

}
