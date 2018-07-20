//
//  GradientView.swift
//  Shapes
//
//  Created by Necanow on 7/16/18.
//  Copyright © 2018 Gaby Ecanow. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .black
    @IBInspectable var isVerticle: Bool = true
    
    //=====================================================
    // Draws a graident background on self
    //=====================================================
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        var endPoint = CGPoint(x: bounds.width, y: 0) // verticle
        if !isVerticle {
            endPoint = CGPoint(x: 0, y: bounds.height) // horizontal
        }
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }

}
