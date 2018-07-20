//
//  ExplanationOneViewController.swift
//  Shapes
//
//  Created by Necanow on 7/18/18.
//  Copyright © 2018 Gaby Ecanow. All rights reserved.
//

import UIKit

class ExplanationOneViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var toolBoxLabel: UILabel!
    @IBOutlet weak var tapAnywhereLabel: UILabel!
    @IBOutlet weak var hideOrShow: UILabel!
    @IBOutlet weak var downArrow: UIButton!
    
    var canTranslate = false
    var canMoveOn = false
    var savedPoints = [Line]()
    var savedPhoto : UIImage?
    
    //=====================================================
    // VIEW DID LOAD
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        pullWelcomeLabel()
    }
    
    //=====================================================
    // Animates the welcome label
    //=====================================================
    func pullWelcomeLabel() {
        welcomeLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        welcomeLabel.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.welcomeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.toolBoxLabel.isHidden = false
            self.pullToolBoxLabel()
        }
    }
    
    //=====================================================
    // Animates the toolbox label
    //=====================================================
    func pullToolBoxLabel() {
        toolBoxLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.toolBoxLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.canTranslate = true
            self.pulseTap()
        }
    }
    
    func translateToolBoxLabel() {
        self.toolBoxLabel.isHidden = true
        self.hideOrShow.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.downArrow.transform = CGAffineTransform(translationX: 15, y: -20)
        }) { (bool) in
            self.canMoveOn = true
        }
    }
    
    //=====================================================
    // Pulses the tap label
    //=====================================================
    func pulseTap() {
        tapAnywhereLabel.isHidden = false
        UIView.animate(withDuration: 2.0, animations: {
            self.tapAnywhereLabel.alpha = 1.0
        }) { (void) in
            self.tapAnywhereLabel.alpha = 0.0
            self.pulseTap()
        }
    }
    
    //=====================================================
    // Handles segue to tutorial page 2
    //=====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canTranslate {
            if canMoveOn {
                performSegue(withIdentifier: "firstExplanationSegue", sender: nil)
            } else {
                self.translateToolBoxLabel()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ExplanationTwoViewController
        dvc.savedPoints = self.savedPoints
        dvc.savedPhoto = self.savedPhoto
    }
}
