//
//  PopoverViewController.swift
//  Shapes
//
//  Created by Gaby Ecanow on 10/19/16.
//  Copyright © 2016 Gaby Ecanow. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var color = Color(r: 0, g: 0, b: 0)
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = color.getColor()
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
    }
    
    
    @IBAction func onRedSlide(_ sender: UISlider) {
        color.red = CGFloat(sender.value)
        self.view.backgroundColor = color.getColor()
    }
    
    @IBAction func onGreenSlide(_ sender: UISlider) {
        color.green = CGFloat(sender.value)
        self.view.backgroundColor = color.getColor()
    }
    
    @IBAction func onBlueSlide(_ sender: UISlider) {
        color.blue = CGFloat(sender.value)
        self.view.backgroundColor = color.getColor()
    }
    
    
    func onTappedButton(sender: UIButton!) {
        self.performSegue(withIdentifier: "unwindSegue", sender: self)
    }
}
