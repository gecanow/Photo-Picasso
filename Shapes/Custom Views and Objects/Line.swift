//
//  Line.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/18/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class Line: NSObject {

    var start : CGPoint!
    var end : CGPoint!
    var color = UIColor.black
    var thickness = 3.0
    var isEraser = false
    var startsATurn = false
    var opacity = 1.0
    
    var drawn = false
    
    //=====================================================
    // INIT
    //=====================================================
    init(begin: CGPoint, close: CGPoint, color: UIColor, width: Double, alpha: Double, starting: Bool) {
        start = begin
        end = close
        self.color = color
        thickness = width
        opacity = alpha
        startsATurn = starting
    }
    
    //=====================================================
    // INIT #2
    //=====================================================
    init(begin: CGPoint, close: CGPoint, width: Double, eraser: Bool, alpha: Double, starting: Bool) {
        start = begin
        end = close
        thickness = width
        isEraser = eraser
        opacity = alpha
        startsATurn = starting
    }
}
