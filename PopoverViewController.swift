//
//  PopoverViewController.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/19/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var color = Color(r: 0, g: 0, b: 0)
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var cameraRollButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var backgroundImage = UIImageView()
    
    var calledByPen = true
    
    //=====================================================
    // VIEW DID LOAD FUNCTION
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.view.backgroundColor = color.getColor()
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        
        redLabel.layer.cornerRadius = 5
        greenLabel.layer.cornerRadius = 5
        blueLabel.layer.cornerRadius = 5
        
        if calledByPen {
            cameraRollButton.isHidden = true
        }
    }
    
    //=====================================================
    // Handles when the red slider is slid
    //=====================================================
    @IBAction func onRedSlide(_ sender: UISlider) {
        color.red = CGFloat(sender.value)
        self.view.backgroundColor = color.getColor()
    }
    
    //=====================================================
    // Handles when the green slider is slid
    //=====================================================
    @IBAction func onGreenSlide(_ sender: UISlider) {
        color.green = CGFloat(sender.value)
        self.view.backgroundColor = color.getColor()
    }
    
    //=====================================================
    // Handles when the blue slider is slid
    //=====================================================
    @IBAction func onBlueSlide(_ sender: UISlider) {
        color.blue = CGFloat(sender.value)
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
