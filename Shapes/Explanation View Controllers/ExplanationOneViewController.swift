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
    var canMoveOn = false
    var didTapQuestion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if !didTapQuestion {
//            print("traversing to VC")
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")
//            self.present(vc, animated: true, completion: nil)
//        }
        pullWelcomeLabel()
    }
    
    func pullWelcomeLabel() {
        welcomeLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.welcomeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.toolBoxLabel.isHidden = false
            self.pullToolBoxLabel()
        }
    }
    
    func pullToolBoxLabel() {
        toolBoxLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.toolBoxLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.tapAnywhereLabel.isHidden = false
            self.pulseTap()
        }
    }
    
    func pulseTap() {
        canMoveOn = true
        UIView.animate(withDuration: 2.0, animations: {
            self.tapAnywhereLabel.alpha = 1.0
        }) { (void) in
            self.tapAnywhereLabel.alpha = 0.0
            self.pulseTap()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canMoveOn {
            performSegue(withIdentifier: "firstExplanationSegue", sender: nil)
        }
    }
    
    @IBAction func unwindToBeginning(segue: UIStoryboardSegue) {}
}
