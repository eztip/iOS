//
//  SettingsViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/6/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit
import Photos

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var employmentEntry: UITextField!
    @IBOutlet weak var taglineEntry: UITextField!
    @IBOutlet weak var timeSpentEntry: UITextField!
    @IBOutlet weak var favoriteItemEntry: UITextField!
    @IBOutlet weak var locationEntry: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    
    let photos = PHPhotoLibrary.authorizationStatus()
    let picker = UIImagePickerController()
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        employmentEntry.delegate = self
        taglineEntry.delegate = self
        timeSpentEntry.delegate = self
        favoriteItemEntry.delegate = self
        locationEntry.delegate = self
        // Do any additional setup after loading the view.
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
