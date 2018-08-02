//
// RecipeViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, Eric Lee, and Jordan Cheung
//
// Bugs(fixed): Recipe name was not showing up properly, recipe name was cut off when displayed, URL link was not working 
//
// Added: URL link to name of the recipe, app would crash when attempting to upload recipes to database, home button was not taking users back to the rootViewController

import UIKit
import FirebaseDatabase

//The view controller of the page that displays your selected Heathy Plate with all of its details
class RecipeViewController: UIViewController {

    // recipe button, and text view objects
    @IBOutlet var recipe_button: UILabel!
    @IBOutlet weak var ingredients_list: UITextView!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var link_label: UIButton!
    
    // opens safari with link if button is clicked
    @IBAction func recipe_URL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    // recipe name, ingredients, and URL link
    var recipe:String = ""
    var ingredients = [String]()
    var recipe_URL:String = ""
    let rootRef = Database.database().reference()
    
    var amounts = [String]()
    var measures = [String]()
    var recipe_instructions:String = ""
    var recipe_tips:String = ""
    var recipe_serving_size:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allows font size in textfield to be resized
        recipe_button.adjustsFontSizeToFitWidth = true
        
        //disable edditting for text field
        ingredients_list.isEditable = false
        
        print("Recipe View Controller")

        //For testing purposes
        print("Final")
        print("Recipe", recipe)
        print("ingredients", ingredients)
        
        
        // if users are not logged in then save button is hidden
        if (UserDefaults.standard.object(forKey: "username") == nil) {
            btnSave.isHidden = true
        }
        
        // make link invisible if there is no link involved with recipe
        if (recipe_URL == "") {
            link_label.isHidden = true
        }
        
        // sets the button title
        recipe_button.text = recipe
        
        // prints all the information associated with the user chosen recipe
        var str_ingredients = String()
        str_ingredients = "Yields: "
        
        var str_ingredients_heading = String()
        str_ingredients_heading = "List of Ingredients: "
        
        var str_instructions = String()
        str_instructions = "Instructions: \n"
        
        var str_tips = String()
        str_tips = "Tips for Healthy Meal! \n"
        
        str_ingredients += recipe_serving_size + "\n\n"
        str_ingredients += str_ingredients_heading + "\n"
        
        for i in 0..<ingredients.count {

            str_ingredients += amounts[i] + " "
            str_ingredients += measures[i] + " "
            str_ingredients += ingredients[i] + "\n"
        }
        
        str_ingredients += "\n"
        str_ingredients += str_instructions
        str_ingredients += recipe_instructions + "\n" + "\n"
        str_ingredients += str_tips
        str_ingredients += recipe_tips
        
        //Display the list of ingredients
        ingredients_list.text = str_ingredients
    }
    
    // if users press the save button, then the recipe, along with its cuisine is uploaded to the database
    @IBAction func btnSave(_ sender: Any) {
        btnSave.isHidden = true
        rootRef.child((UserDefaults.standard.object(forKey: "username") as? String)!).child(recipe).setValue([recipe, Shared.shared.selected_cuisine])
    }
    
    // if users press the home button, they are taken to the rootViewController
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
