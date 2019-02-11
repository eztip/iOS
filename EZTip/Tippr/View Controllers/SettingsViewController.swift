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
    
    
    @IBOutlet weak var occupationEntry: UITextField!
    @IBOutlet weak var taglineEntry: UITextField!
    @IBOutlet weak var timeSpentEntry: UITextField!
    
    
    let photos = PHPhotoLibrary.authorizationStatus()
    let picker = UIImagePickerController()
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        occupationEntry.delegate = self
        taglineEntry.delegate = self
        timeSpentEntry.delegate = self
        profileImage.image = controller.currentWorkerImage
        taglineEntry.text = controller.currentWorker?.tagline
        timeSpentEntry.text = controller.currentWorker?.workingSince
        occupationEntry.text = controller.currentWorker?.occupation
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
    @IBAction func updateProfileTapped(_ sender: Any) {
        var newWorker = controller.currentWorker
        newWorker?.tagline = taglineEntry.text!
        newWorker?.workingSince = timeSpentEntry.text!
        newWorker?.occupation = occupationEntry.text!
        controller.updateProfile(updatedWorker: newWorker!) { (error, worker) in
            if let error = error{
                print(error)
            }
        }
        controller.updateWorkerImage(image: profileImage.image!) { (error) in
            if let error = error{
                print(error)
            }
        }
        let alert = UIAlertController(title: "Success", message: "Profile updated successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
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
