//
//  LoginViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/4/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var passwordEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
    }
    @IBAction func login(_ sender: Any) {
        controller.loginUser(username: usernameEntry.text!, password: passwordEntry.text!) { (error, token) in
            DispatchQueue.main.async {
                if controller.wasError == true{
                    let alert = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                
                loggedInToken = token
                let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginTabBarController") as! UITabBarController
                tabBar.view.frame = UIScreen.main.bounds
                self.present(tabBar, animated: true)
            }
        }
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
