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
    
    @IBOutlet weak var penColorButton: UIButton!
    @IBOutlet weak var canvasColorButton: UIButton!
    
    @IBOutlet weak var toolBox: UIView!
    @IBOutlet weak var hideToolboxButton: UIButton!
    
    var startPoint : CGPoint!
    var endPoint : CGPoint!
    
    var eraser = false
    var thickness = 3.0
    var opacity = 1.0
    
    var penColor = Color(h: 0.0, s: 1.0, b: 1.0)
    var canvasColor = Color(h: 0.5, s: 0.0, b: 1.0)
    
    var isPenColor = true
    var didTapQuestion = false
    
    var isBeginning = false
    var savedPoints = [Line]()
    var savedPhoto : UIImage?
    
    //=====================================================
    // VIEW DID LOAD FUNCTION
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasicUI()
    }
    
    //=====================================================
    // Handles when the toolbox button is tapped
    //=====================================================
    @IBAction func onPressedToolboxButton(_ sender: UIButton) {
        if sender.tag == 0 { //currentTitle == "Hide Toolbox" {
            transformToolbox(toY: self.toolBox.frame.height, newTag: 1)//newTitle: "Show Toolbox")
        } else {
            transformToolbox(toY: 0, newTag: 0)//newTitle: "Hide Toolbox")
        }
    }
    
    func transformToolbox(toY: CGFloat, newTag: Int) {
        UIView.animate(withDuration: 0.4, animations: {
            self.toolBox.transform = CGAffineTransform(translationX: 0, y: toY)
            self.hideToolboxButton.transform = CGAffineTransform(translationX: 0, y: toY)
        }) { (void) in
            let imageNames = ["down", "up"]
            self.hideToolboxButton.setImage(UIImage(named: imageNames[newTag]), for: .normal)
            self.hideToolboxButton.tag = newTag
        }
    }
    
    //=====================================================
    // Controls the width/thickness of the pen
    //=====================================================
    @IBAction func onSlide(_ sender: UISlider) {
        thickness = Double(sender.value) * 10 + 3
    }
    
    @IBAction func onSlideAlpha(_ sender: UISlider) {
        opacity = Double(sender.value)
    }
    
    //=====================================================
    // Handles when the touches begin
    //=====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint = touches.first?.location(in: myDrawView)
        isBeginning = true
    }
    
    //=====================================================
    // Handles whenever the user drags their finger 
    // across the screen, and appends the line to the 
    // draw view array
    //=====================================================
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endPoint = touch.location(in: myDrawView)
            
            if eraser {
                myDrawView.points.append(Line(begin: startPoint, close: endPoint, width: thickness, eraser: true, alpha: opacity, starting: isBeginning))
            } else {
                myDrawView.points.append(Line(begin: startPoint, close: endPoint, color: penColor.getColor(), width: thickness, alpha: opacity, starting: isBeginning))
            }
            isBeginning = false
            startPoint = endPoint
            myDrawView.setNeedsDisplay()
        }
    }
    
    //=====================================================
    // Handles when the clear button is tapped
    //=====================================================
    @IBAction func onTappedClear(_ sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Are you sure you would like to clear your drawing?", message: "", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Clear Drawing", style: .default) { (Void) in
            self.myDrawView.points = [Line]()
            self.myBackground.image = nil
            self.removeImageButton.isHidden = true
            self.myDrawView.setNeedsDisplay()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //=====================================================
    // Handles when the undo button is pressed
    //=====================================================
    @IBAction func onTappedUndo(_ sender: AnyObject) {
        myDrawView.undoLastMove()
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
        //myEraser.isEnabled = true
    }
    
    //=====================================================
    // Handles saving the image to the user's library
    //=====================================================
    @IBAction func onTappedSave(_ sender: AnyObject) {
        let activity = UIActivityViewController(activityItems: [fullImage() as Any], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        present(activity, animated: true, completion: nil)
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
        toolBox.isHidden = true
        hideToolboxButton.isHidden = true
        
        // then take the snapshot
        let size = myBackground.frame.size
        UIGraphicsBeginImageContext(size)
        self.view!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        myBackground.transform = CGAffineTransform.identity
        myDrawView.transform = CGAffineTransform.identity
        
        // then unhide everything
        if hasImage {
            removeImageButton.isHidden = false
        }
        toolBox.isHidden = false
        hideToolboxButton.isHidden = false
        
        return image!
    }
    
    //=====================================================
    // Segues to the tutorial VC if ? is tapped
    //=====================================================
    @IBAction func onTappedQuestion(_ sender: AnyObject) {
        didTapQuestion = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Tutorial") as! ExplanationOneViewController
        vc.savedPoints = myDrawView.points // save the drawing
        vc.savedPhoto = myBackground.image // save the background image
        self.present(vc, animated: true, completion: nil)
    }
    
    //=====================================================
    // Handles setting up the basic ui, called in 
    // viewDidLoad()
    //=====================================================
    func setUpBasicUI() {
        // give the popover a delegate
        popoverPresentationController?.delegate = self
        
        // set up ui stuff
        myDrawView.backgroundColor = canvasColor.getColor()
        penColorButton.layer.backgroundColor = penColor.getColor().cgColor
        canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
        myBackground.contentMode = .scaleAspectFit
        
        // resort to anything saved, is applicable
        if !savedPoints.isEmpty {
            myDrawView.points = savedPoints
        }
        if savedPhoto != nil {
            myBackground.image = savedPhoto
            
            myDrawView.backgroundColor = UIColor.clear
            removeImageButton.isHidden = false
            eraser = false
        }
    }
    
    //=================================================
    // segues
    //=================================================
    
    //=================================================
    // Prepare for segue to popover
    //=================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !didTapQuestion {
            let dvc = segue.destination as! PopoverViewController
            dvc.modalPresentationStyle = UIModalPresentationStyle.popover
            dvc.popoverPresentationController!.delegate = self
            
            if isPenColor {
                dvc.color = penColor
                dvc.eraserOn = eraser
                dvc.calledByPen = true
                
                if self.myBackground.image != nil {
                    dvc.eraserOn = false
                    dvc.eraserEnabled = false
                }
            } else {
                dvc.color = canvasColor
                dvc.calledByPen = false
            }
        
            dvc.backgroundImage = myBackground
        }
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
            eraser = ppc.eraserSwitch.isOn
            
            if !eraser {
                penColorButton.setImage(UIImage(named: "pencil2"), for: .normal) //crayon outline
                penColorButton.layer.backgroundColor = penColor.getColor().cgColor
            } else {
                penColorButton.setImage(UIImage(named: "eraser"), for: .normal)
                penColorButton.layer.backgroundColor = UIColor.white.cgColor
            }
        } else {
            canvasColor = ppc.color
            canvasColorButton.layer.backgroundColor = canvasColor.getColor().cgColor
            myDrawView.backgroundColor = canvasColor.getColor()
            
            if ppc.backgroundImage.image != nil {
                myBackground.image = ppc.backgroundImage.image
                myDrawView.backgroundColor = UIColor.clear
                removeImageButton.isHidden = false
                
                eraser = false
            }
        }
    }
}

