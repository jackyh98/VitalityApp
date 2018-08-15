//
// IngredientViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by and worked on by Jacky Huynh
//
// Bugs(fixed): Objects were not displaying in the right positions and sizes, back button was also missing

import UIKit

class IngredientViewController: UIViewController {

    // List of ingredients
    @IBOutlet weak var ingredient_list: UITextView!
    
    //ingredients to be displayed
    var veg_selected_ingredients = Shared.shared.veg_selected_ingredients
    var meat_selected_ingredients = Shared.shared.meat_selected_ingredients
    var grain_selected_ingredients = Shared.shared.grain_selected_ingredients
    var dairy_selected_ingredients = Shared.shared.dairy_selected_ingredients
    
    
    var str_veg = String()
    var str_meat = String()
    var str_grain = String()
    var str_dairy = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //disable editting for textfield
        ingredient_list.isEditable = false
        
        //testing purposes
        print("vegetables selected", veg_selected_ingredients)
        print("meats selected", meat_selected_ingredients)
        print("grains selected", grain_selected_ingredients)
        print("dairys selected", dairy_selected_ingredients, "\n")
        
        //Display the name of the ingredients on the test box
        str_veg = "Vegetable Ingredients:\n "
        str_meat = "\nMeat Ingredients:\n "
        str_grain = "\nGrain Ingredients:\n "
        str_dairy = "\nDairy Ingredients:\n "
        
        if veg_selected_ingredients.isEmpty {
            str_veg += "None\n"
        }
        for veg_ing in veg_selected_ingredients {
            
            str_veg += veg_ing + "\n "
            
        }
        
        if meat_selected_ingredients.isEmpty {
            str_meat += "None\n"
        }
        
        for meat_ing in meat_selected_ingredients {
            
            str_meat += meat_ing + "\n "
            
        }
        
        if grain_selected_ingredients.isEmpty {
            str_grain += "None\n"
        }
        for grain_ing in grain_selected_ingredients {
            
            str_grain += grain_ing + "\n "
            
        }
        
        if dairy_selected_ingredients.isEmpty {
            str_dairy += "None\n"
        }
        for dairy_ing in dairy_selected_ingredients {
            
            str_dairy += dairy_ing + "\n "
            
        }
        
        //display ingredients that user selected in order
        ingredient_list.text =  str_veg + str_grain + str_dairy + str_meat
        
    }

}
