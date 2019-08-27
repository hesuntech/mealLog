//
//  ViewController.swift
//  mealLog
//
//  Created by Jianli He on 6/27/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    var newmeal: meal?
    @IBOutlet weak var mealNameField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameField.delegate=self
        
        if let newmeal = newmeal {
            navigationItem.title=newmeal.name
            mealNameField.text=newmeal.name
            photoImageView.image=newmeal.photo
            ratingControl.rating=newmeal.rating
        }
        
        updateButtonStatus()
        
        // Do any additional setup after loading the view.
    }
    //MARK: UIImagePickerControllerdelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage else {
            fatalError("Problem happened with this info \(info)")
        }
        photoImageView.image=selectedImage
        dismiss(animated: true, completion: nil)
    }
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isAddMode = (presentingViewController is UINavigationController)
        if isAddMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("not in a navigation controller")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button=sender as? UIBarButtonItem, button==saveButton else {
            os_log("button is not save button", log: OSLog.default, type:.debug)
            return
        }
        let name=mealNameField.text ?? ""
        let photo=photoImageView.image
        let rating=ratingControl.rating
        newmeal=meal(name:name,photo:photo,rating:rating)
    }
    
    //MARK: Actions
  
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("ok")
        mealNameField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        mealNameField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled=false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonStatus()
        navigationItem.title=mealNameField.text
        
    }
    //MARK: private
    func updateButtonStatus() {
        let text=mealNameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

