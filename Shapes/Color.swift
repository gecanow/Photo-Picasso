//
//  Color.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/19/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class Color: NSObject {
    
    var red = CGFloat(0.0)
    var green = CGFloat(0.0)
    var blue = CGFloat(0.0)
    
    //=====================================================
    // INIT
    //=====================================================
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init()
        red = r
        green = g
        blue = b
    }
    
    //=====================================================
    // Returns the UIColor of this color
    //=====================================================
    func getColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
