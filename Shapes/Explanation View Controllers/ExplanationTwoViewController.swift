//
//  ExplanationTwoViewController.swift
//  Shapes
//
//  Created by Necanow on 7/18/18.
//  Copyright © 2018 Gaby Ecanow. All rights reserved.
//

import UIKit

class ExplanationTwoViewController: UIViewController {
    
    @IBOutlet weak var actionView: GradientView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var canvasButton: UIButton!
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var tapAnywhereLabel: UILabel!
    
    var indexOn = 0
    var explanations = ["In the Action Section, you can clear your drawing, undo your last move, save your drawing to your photo library, or access these instructions.", "You can slide the opacity slider or the width slider to change the opacity and width of your pencil.", "Tap on the pencil to change your pencil color or switch to an eraser.", "Tap on the canvas to change your canvas color or set your background to a picture from your photo library."]
    var savedPoints = [Line]()
    var savedPhoto : UIImage?
    
    //=====================================================
    // VIEW DID LOAD
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        pulseTap()
        transform(section: indexOn)
    }
    
    //=====================================================
    // Transform a certain @section of the toolbox
    //=====================================================
    func transform(section: Int) {
        let over = CGFloat(150)
        
        switch section {
        case 0:
            UIView.animate(withDuration: 0.4, animations: {
                self.actionView.transform = CGAffineTransform(translationX: 0, y: -over)
            })
        case 1:
            UIView.animate(withDuration: 0.4, animations: {
                self.sliderView.transform = CGAffineTransform(translationX: 0, y: -over)
                self.actionView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        case 2:
            UIView.animate(withDuration: 0.4, animations: {
                self.pencilButton.transform = CGAffineTransform(translationX: 0, y: -over)
                self.sliderView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        case 3:
            UIView.animate(withDuration: 0.4, animations: {
                self.canvasButton.transform = CGAffineTransform(translationX: 0, y: -over)
                self.pencilButton.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.canvasButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }) { (bool) in
                self.performSegue(withIdentifier: "secondExplanationSegue", sender: nil)
            }
        }
    }
    
    //=====================================================
    // Pulses the tap label
    //=====================================================
    func pulseTap() {
        UIView.animate(withDuration: 2.0, animations: {
            self.tapAnywhereLabel.alpha = 1.0
        }) { (void) in
            self.tapAnywhereLabel.alpha = 0.0
            self.pulseTap()
        }
    }
    
    //=====================================================
    // Handles segue to tutorial page 3
    //=====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        indexOn += 1
        transform(section: indexOn)
        if indexOn < explanations.count {
            explanationLabel.text = explanations[indexOn]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ExplanationThreeViewController
        dvc.savedPoints = self.savedPoints
        dvc.savedPhoto = self.savedPhoto
    }
}
