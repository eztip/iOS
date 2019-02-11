//
//  SignupViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/4/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var passwordEntry: UITextField!
    @IBOutlet weak var firstNameEntry: UITextField!
    @IBOutlet weak var lastNameEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let user = User(name: usernameEntry.text!, pass: passwordEntry.text!)
        controller.registerUser(user: user) { (error, token) in
            loggedInToken = token
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var worker = Worker()
        worker.username = usernameEntry.text!
        worker.firstName = firstNameEntry.text!
        worker.lastName = lastNameEntry.text!
        let destination = segue.destination as! ProfileViewController
        destination.worker = worker
    }
}
