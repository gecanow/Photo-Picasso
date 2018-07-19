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
    var savedPoints = [Line]()
    var savedPhoto : UIImage?
    
    //=====================================================
    // VIEW DID LOAD
    //=====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        showFinalAdvice()
    }
    
    //=====================================================
    // Animates the final advice
    //=====================================================
    func showFinalAdvice() {
        finalAdvice.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.finalAdvice.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (bool) in
            self.canMoveOn = true
        }
    }
    
    //=====================================================
    // Segues to the draw center
    //=====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canMoveOn {
            performSegue(withIdentifier: "thirdExplanationSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        dvc.savedPoints = self.savedPoints
        dvc.savedPhoto = self.savedPhoto
    }
}
