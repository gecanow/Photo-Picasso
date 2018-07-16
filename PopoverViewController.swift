//
//  PopoverViewController.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/19/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var color = Color(h: 0, s: 0, b: 0)
    
    @IBOutlet weak var hueSlider: UISlider!
    
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var saturationBackground: GradientView!
    
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var brightnessBackground: GradientView!
    
    @IBOutlet weak var cameraRollButton: UIButton!
    @IBOutlet weak var eraserStack: UIStackView!
    @IBOutlet weak var eraserSwitch: UISwitch!
    var eraserOn = false
    var eraserEnabled = true
    
    var imagePicker = UIImagePickerController()
    var backgroundImage = UIImageView()
    
    var calledByPen = true
    
    //=====================================================
    // VIEW DID LOAD FUNCTION
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        hueSlider.value = Float(color.hue)
        saturationSlider.value = Float(color.saturation)
        brightnessSlider.value = Float(color.brightness)
        updateBackgrounds()
        
        if calledByPen {
            cameraRollButton.isHidden = true
            
            if eraserEnabled {
                eraserStack.isHidden = false
                eraserSwitch.isOn = eraserOn
            } else {
                eraserStack.isHidden = true
            }
        } else {
            cameraRollButton.isHidden = false
            eraserStack.isHidden = true
        }
    }
    
    //=====================================================
    // Handles when the red slider is slid
    //=====================================================
    @IBAction func onHueSlide(_ sender: UISlider) {
        color.hue = CGFloat(sender.value)
        updateBackgrounds()
    }
    
    @IBAction func onSaturationSlide(_ sender: UISlider) {
        color.saturation = CGFloat(sender.value)
        updateBackgrounds()
    }
    
    @IBAction func onBrightnessSlide(_ sender: UISlider) {
        color.brightness = CGFloat(sender.value)
        updateBackgrounds()
    }
    
    func updateBackgrounds() {
        brightnessBackground.endColor = color.getColor()
        brightnessBackground.setNeedsDisplay()
        
        saturationBackground.endColor = color.getColor()
        saturationBackground.setNeedsDisplay()
        
        self.view.backgroundColor = color.getColor()
    }
    
    //=====================================================
    // Handles when the user pressed camera roll
    //=====================================================
    @IBAction func didPressCameraRoll(_ sender: AnyObject) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    //=====================================================
    // Controls the image picker
    //=====================================================
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true) {
            self.backgroundImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismissMyself()
        }
    }
    
    //=====================================================
    // Handles dismissing myself and calling the 
    // popoverPresentationControllerDidDismissPopover
    // function manually
    //=====================================================
    func dismissMyself() {
        dismiss(animated: false, completion: nil)
        popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover!(popoverPresentationController!)
    }
}
