//
//  ViewController.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/17/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var myDrawView: DrawView!
    @IBOutlet weak var penColorButton: UIButton!
    
    var startPoint : CGPoint!
    var endPoint : CGPoint!
    
    var eraser = false
    var thickness = 3.0
    
    var penColor = Color(r: 0, g: 0, b: 0)
    var canvasColor = Color(r: 0.5, g: 0.5, b: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDrawView.backgroundColor = canvasColor.getColor()
        penColorButton.backgroundColor = penColor.getColor()
        print("here")
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
            myDrawView.points.append(Line(begin: startPoint, close: endPoint, color: penColor.getColor(), width: thickness))
        }
        
        startPoint = endPoint
        myDrawView.setNeedsDisplay()
    }
    
    @IBAction func onTappedClear(_ sender: AnyObject) {
        myDrawView.points = [Line]()
        myDrawView.setNeedsDisplay()
    }
    
    //=================================================
    // segues
    //=================================================
    
    @IBAction func prepareForUnwind(unwindSegue: UIStoryboardSegue) {
        let mvc = unwindSegue.source as! PopoverViewController
        penColor = mvc.color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PopoverViewController
        dvc.modalPresentationStyle = UIModalPresentationStyle.popover
        dvc.popoverPresentationController!.delegate = self
        dvc.color = penColor
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        return .none
    }
    
}

