//
//  ExplanationThreeViewController.swift
//  Shapes
//
//  Created by Necanow on 7/18/18.
//  Copyright © 2018 Gaby Ecanow. All rights reserved.
//

import UIKit

class ExplanationThreeViewController: UIViewController {
    
    @IBOutlet weak var finalAdvice: UILabel!
    
    var canMoveOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFinalAdvice()
    }
    
    func showFinalAdvice() {
        finalAdvice.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.finalAdvice.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.canMoveOn = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canMoveOn {
            performSegue(withIdentifier: "thirdExplanationSegue", sender: nil)
        }
    }
}
