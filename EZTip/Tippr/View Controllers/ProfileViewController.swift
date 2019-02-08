//
//  ProfileViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/4/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit
import Photos

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var employmentEntry: UITextField!
    @IBOutlet weak var timeSpentEntry: UITextField!
    @IBOutlet weak var menuItemEntry: UITextField!
    @IBOutlet weak var locationEntry: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    let photos = PHPhotoLibrary.authorizationStatus()
    let picker = UIImagePickerController()
    @IBOutlet weak var taglineEntry: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        employmentEntry.delegate = self
        timeSpentEntry.delegate = self
        menuItemEntry.delegate = self
        locationEntry.delegate = self
        taglineEntry.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({_ in
                //do nothing
            })
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 1){
            employmentEntry.isHidden = true
            timeSpentEntry.isHidden = true
            menuItemEntry.isHidden = true
            locationEntry.isHidden = true
        }else{
            employmentEntry.isHidden = false
            timeSpentEntry.isHidden = false
            menuItemEntry.isHidden = false
            locationEntry.isHidden = false
        }
    }
    
    
    @IBAction func addPhoto(_ sender: Any) {
        
        
        if PHPhotoLibrary.authorizationStatus() == .authorized{
            self.present(self.picker, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "You have not granted this app permission to your photo gallery. Please do so in your settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
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
