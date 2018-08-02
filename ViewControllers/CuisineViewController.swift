//
// CuisineViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, Eric Lee, and Jordan Cheung
//
// Bugs(Fixed): Select button did not change to the cuisine name that was selected, back button would disappear, users can press next if no cuisines were selected

import UIKit

class CuisineViewController: UIViewController {
    
    // Cuisine selecting button, and next button objects
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet var btnnext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the next button when viewcontroller is initially shown
        btnnext.isHidden = true
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        
        // assigns cuisine label
        Shared.shared.selected_cuisine = "---------"
        
    }
    
    // After returning back to view controller with selected cuisine, change the label of the button to the cuisine name, and display the next button 
    override func viewWillAppear(_ animated: Bool) {
        if (Shared.shared.selected_cuisine != "---------") {
            btnnext.isHidden = false
            btnSelect.setTitle(Shared.shared.selected_cuisine, for: .normal)
        }
    }
}
