//
//  ViewController.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/17/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myDrawView: DrawView!
    
    var startPoint : CGPoint!
    var endPoint : CGPoint!
    
    var eraser = false
    var color = UIColor.black
    var thickness = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSwitched(_ sender: UISwitch) {
        if sender.isOn {
            eraser = true
        } else {
            eraser = false
        }
    }
    
    @IBAction func onSlide(_ sender: UISlider) {
        thickness = Double(sender.value) * 10 + 3
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint = touches.first?.location(in: myDrawView)
    }
    
    @IBAction func onDrag(_ sender: UIPanGestureRecognizer) {
        endPoint = sender.location(in: myDrawView)
        
        if eraser {
            myDrawView.points.append(Line(begin: startPoint, close: endPoint, color: myDrawView.backgroundColor!, width: thickness))
        } else {
            myDrawView.points.append(Line(begin: startPoint, close: endPoint, color: color, width: thickness))
        }
        
        startPoint = endPoint
        myDrawView.setNeedsDisplay()
    }
    
    @IBAction func onTappedClear(_ sender: AnyObject) {
        myDrawView.points = [Line]()
        myDrawView.setNeedsDisplay()
    }
    
}

