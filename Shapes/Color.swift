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
    
    var hue = CGFloat(0.0)
    var saturation = CGFloat(1.0)
    var brightness = CGFloat(1.0)
    
    //=====================================================
    // INIT
    //=====================================================
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init()
        red = r
        green = g
        blue = b
    }
    
    convenience init(h: CGFloat, s: CGFloat, b: CGFloat) {
        self.init()
        hue = h
        saturation = s
        brightness = b
    }
    
    //=====================================================
    // Returns the UIColor of this color
    //=====================================================
    func getColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func getMyColor() -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
}
