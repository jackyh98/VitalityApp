//
// SelectionViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, and Eric Lee
//
// Bugs(fixed): back button was missing, can go to next view controller without selecting my ingredients

import UIKit

class SelectionViewController: UIViewController {
    
    // objects
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet var btnnext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // next button initially hidden
        btnnext.isHidden = true
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        
        //testing purposes
        print("Veg:")
        print(Shared.shared.veg_selected_ingredients)
        print("Meat:")
        print(Shared.shared.meat_selected_ingredients)
        print("Grain:")
        print(Shared.shared.grain_selected_ingredients)
        print("Dairy:")
        print(Shared.shared.dairy_selected_ingredients)
    }
    
    // after a ingredient is selected, and this viewcontroller is revisited next button appears
    override func viewWillAppear(_ animated: Bool) {
        if ( Shared.shared.veg_selected_ingredients.isEmpty != true ||
             Shared.shared.meat_selected_ingredients.isEmpty != true ||
             Shared.shared.grain_selected_ingredients.isEmpty != true ||
             Shared.shared.dairy_selected_ingredients.isEmpty != true ) {
            
            btnnext.isHidden = false
        }
    }
    
}

