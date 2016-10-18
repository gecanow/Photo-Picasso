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
    
    init(begin: CGPoint, close: CGPoint, color: UIColor, width: Double) {
        start = begin
        end = close
        self.color = color
        thickness = width
    }
}
