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
    @IBOutlet weak var canvasColorButton: UIButton!
    @IBOutlet weak var toolBox: UILabel!
    
    var startPoint : CGPoint!
    var endPoint : CGPoint!
    
    var eraser = false
    var thickness = 3.0
    
    var penColor = Color(r: 0, g: 0, b: 0)
    var canvasColor = Color(r: 0.8, g: 0.8, b: 0.8)
    
    var isPenColor = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDrawView.backgroundColor = canvasColor.getColor()
        
        penColorButton.layer.borderWidth = 2
        penColorButton.layer.cornerRadius = 5
        penColorButton.layer.backgroundColor = penColor.getColor().cgColor
        
        canvasColorButton.layer.borderWidth = 2
        canvasColorButton.layer.cornerRadius = 5
        canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
        
        myDrawView.layer.cornerRadius = 7
        toolBox.layer.cornerRadius = 7
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
            myDrawView.points.append(Line(begin: startPoint, close: endPoint, width: thickness, eraser: true))
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
    
    @IBAction func onTappedPenColor(_ sender: AnyObject) {
        isPenColor = true
    }
    
    @IBAction func onTappedCanvasColor(_ sender: AnyObject) {
        isPenColor = false
    }
    
    //=================================================
    // segues
    //=================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PopoverViewController
        dvc.modalPresentationStyle = UIModalPresentationStyle.popover
        dvc.popoverPresentationController!.delegate = self
        
        if isPenColor {
            dvc.color = penColor
        } else {
            dvc.color = canvasColor
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        let ppc = popoverPresentationController.presentedViewController as! PopoverViewController
        
        if isPenColor {
            penColor = ppc.color
            penColorButton.layer.backgroundColor = penColor.getColor().cgColor
        } else {
            canvasColor = ppc.color
            canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
            myDrawView.backgroundColor = canvasColor.getColor()
        }
    }
}

