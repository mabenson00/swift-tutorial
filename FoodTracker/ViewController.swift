//
//  ViewController.swift
//  FoodTracker
//
//  Created by Apprentice on 4/25/17.
//
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks. Self refers to view controller
        nameTextField.delegate = self
        
        //enable the save button only if the text field has a valid meal name.
        updateSaveButtonState()
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable the save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState() //enables save button
        navigationItem.title = textField.text // changes the navigation header to this
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) { // dictionary with key as string value as any
        // the info dictionary may contain multiple representations of the image. you want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker 
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    //this method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) //call this whenever you override prepare for sender
        
        //configure the destination view controller only when the save button is pressed
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("the save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //set the meal to be passed to the MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    
    }
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a veiw controller that lets a user pick emdia from their photo library
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }

    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the save button if the text field is empty.
        
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

