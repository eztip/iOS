//
//  ProfileCompletionViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/4/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class ProfileCompletionViewController: UIViewController {

    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var checkmarkBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var greenCircle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkmarkBottomConstraint.constant = -400
        greenCircle.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7, animations: {
                self.checkmark.center = self.greenCircle.center
            })
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                self.greenCircle.transform = .identity
            }, completion: nil)
        }, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
