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
    @IBOutlet weak var myBackground: UIImageView!
    
    @IBOutlet weak var removeImageButton: UIButton!
    @IBOutlet weak var myEraser: UISwitch!
    
    @IBOutlet weak var penColorButton: UIButton!
    @IBOutlet weak var canvasColorButton: UIButton!
    @IBOutlet weak var toolBoxView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var hideToolboxButton: UIButton!
    
    
    var startPoint : CGPoint!
    var endPoint : CGPoint!
    
    var eraser = false
    var thickness = 3.0
    
    var penColor = Color(r: 0, g: 0, b: 0)
    var canvasColor = Color(r: 0.8, g: 0.8, b: 0.8)
    
    var isPenColor = true
    
    //=====================================================
    // VIEW DID LOAD FUNCTION
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popoverPresentationController?.delegate = self
        
        myDrawView.backgroundColor = canvasColor.getColor()
        
        penColorButton.layer.borderWidth = 2
        penColorButton.layer.cornerRadius = 5
        penColorButton.layer.backgroundColor = penColor.getColor().cgColor
        
        canvasColorButton.layer.borderWidth = 2
        canvasColorButton.layer.cornerRadius = 5
        canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
        
        //myDrawView.layer.cornerRadius = 7
        //toolBox.layer.cornerRadius = 7
        toolBoxView.layer.cornerRadius = 7
        //myBackground.layer.cornerRadius = 7
        myBackground.backgroundColor = UIColor.clear
        myBackground.contentMode = .scaleAspectFit
    }
    
    
    @IBAction func onPressedToolboxButton(_ sender: UIButton) {
        
        if sender.currentTitle == "Hide Toolbox" {
            
        } else {
            sender.setTitle("Hide Toolbox", for: .normal)
        }
    }
    
    //=====================================================
    // Turns the eraser on/off
    //=====================================================
    @IBAction func onSwitched(_ sender: UISwitch) {
        if sender.isOn {
            eraser = true
        } else {
            eraser = false
        }
    }
    
    //=====================================================
    // Controls the width/thickness of the pen
    //=====================================================
    @IBAction func onSlide(_ sender: UISlider) {
        thickness = Double(sender.value) * 10 + 3
    }
    
    //=====================================================
    // Handles when the touches begin
    //=====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint = touches.first?.location(in: myDrawView)
    }
    
    //=====================================================
    // Handles whenever the user drags their finger 
    // across the screen, and appends the line to the 
    // draw view array
    //=====================================================
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
    
    //=====================================================
    // Handles when the clear button is tapped
    //=====================================================
    @IBAction func onTappedClear(_ sender: AnyObject) {
        myDrawView.points = [Line]()
        myDrawView.setNeedsDisplay()
    }
    
    //=====================================================
    // Handles when the pen color button is tapped
    //=====================================================
    @IBAction func onTappedPenColor(_ sender: AnyObject) {
        isPenColor = true
    }
    
    //=====================================================
    // Handles when the canvas color button is tapped
    //=====================================================
    @IBAction func onTappedCanvasColor(_ sender: AnyObject) {
        isPenColor = false
    }
    
    //=====================================================
    // Handles when the user removes a background image
    //=====================================================
    @IBAction func onTappedRemoveImage(_ sender: UIButton) {
        myBackground.image = nil
        myDrawView.backgroundColor = canvasColor.getColor()
        sender.isHidden = true
        myEraser.isEnabled = true
    }
    
    //=====================================================
    // Handles saving the image to the user's library
    //=====================================================
    @IBAction func onTappedSave(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(fullImage(), nil, nil, nil)
        
        let actionSheet = UIAlertController(title: "Your Photo Has Been Saved!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        actionSheet.addAction(okAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //=====================================================
    // Returns a uiimage of the drawing
    //=====================================================
    func fullImage() -> UIImage {
        
        // check is remove button is hidden
        var hasImage = true
        if removeImageButton.isHidden {
            hasImage = false
        }
        
        // first make everything hidden
        removeImageButton.isHidden = true
        clearButton.isHidden = true
        saveButton.isHidden = true
        toolBoxView.isHidden = true
        
        // then take the snapshot
        let size = myBackground.frame.size
        UIGraphicsBeginImageContext(size)
        self.view!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        myBackground.transform = CGAffineTransform.identity
        myDrawView.transform = CGAffineTransform.identity
        
        // the unhide everything
        if hasImage {
            removeImageButton.isHidden = false
        }
        clearButton.isHidden = false
        saveButton.isHidden = false
        toolBoxView.isHidden = false
        
        return image!
    }
    
    //=================================================
    // segues
    //=================================================
    
    //=================================================
    // Prepare for segue to popover
    //=================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PopoverViewController
        dvc.modalPresentationStyle = UIModalPresentationStyle.popover
        dvc.popoverPresentationController!.delegate = self
        
        if isPenColor {
            dvc.color = penColor
            dvc.calledByPen = true
        } else {
            dvc.color = canvasColor
            dvc.calledByPen = false
        }
        
        dvc.backgroundImage = myBackground
    }
    
    //=================================================
    // For popover
    //=================================================
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        return .none
    }
    
    //=================================================
    // Is called when the popover is dismissed
    //=================================================
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        let ppc = popoverPresentationController.presentedViewController as! PopoverViewController
        
        if isPenColor {
            penColor = ppc.color
            penColorButton.layer.backgroundColor = penColor.getColor().cgColor
        } else {
            canvasColor = ppc.color
            canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
            myDrawView.backgroundColor = canvasColor.getColor()
            
            if ppc.backgroundImage.image != nil {
                myBackground.image = ppc.backgroundImage.image
                myDrawView.backgroundColor = UIColor.clear
                removeImageButton.isHidden = false
                myEraser.isEnabled = false
            }
        }
    }
}

