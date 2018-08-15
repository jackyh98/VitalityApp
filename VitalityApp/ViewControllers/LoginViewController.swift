//
//  LoginViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-26.
//
// Bugs(fixed): Keyboard was not being dismissed when clicking outside the keyboard or hitting the return key, if users entered special characters or no characters at all the application would break

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // UserInput text field object
    @IBOutlet var userInput: UITextField!
    
    // set of characters that are allowed for usernames
    let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

    // confirm button label object
    @IBOutlet var confirmbtnlabel: UIButton!
    
    // cancel button, dismisses viewcontroller
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // confirm button, saves username entered
    @IBAction func confirmBtn(_ sender: Any) {
        
        // users are only allowed to enter letters and numbers, alerts users if they entered a invalid username
        if ( userInput.text?.rangeOfCharacter(from: characterSet.inverted) == nil && userInput.text != "" ) {
            UserDefaults.standard.set(userInput.text, forKey: "username")
            dismiss(animated: true, completion: nil)
        }
        else {
            createAlert(title: "Invalid Username", message: "Please only enter letters and numbers")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // if keyboard is up and users touches outside the keyboard, then keyboard is dimissed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // if users press return on keyboard, keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // function that can be called to create alerts
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
