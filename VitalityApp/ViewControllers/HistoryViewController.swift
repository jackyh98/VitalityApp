//
//  HistoryViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-23.
//
// Bugs(fixed): Recipes would get fetched more than once and would get displayed more than once on the tableview, app would crash when trying to decode the json files because of wrong formatting, confirm button would crash because proper data was not fetched

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // confirm button object
    @IBOutlet var btnconfirm: UIButton!
    
    // getting all the recipes saved in the database
    var recipes_list = Shared.shared.recipe_database
    
    // confirm button is initially hidden
    override func viewDidLoad() {
        btnconfirm.isHidden = true
        super.viewDidLoad()

    }
    
    // Sets number of rows for the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes_list.count
    }
    
    // Creates the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = recipes_list[indexPath.row][0]
        return cell
    }
    
    // detects when a cell in the table is selected, and assigns a checkmark to that cell, and removes all other checkmarks
    // as well as assigning the chosen cell data to variables accordingly
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Shared.shared.recipe_chosen = recipes_list[indexPath.row][0]
        Shared.shared.selected_cuisine = recipes_list[indexPath.row][1]
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark)  {
            for i in 0...recipes_list.count {
                tableView.cellForRow(at: [0, i])?.accessoryType = UITableViewCellAccessoryType.none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }
        if ( Shared.shared.recipe_chosen.isEmpty != true ) {
            btnconfirm.isHidden = false
        }
    }
    
    // if the confirm button is selected saves the recipe ingredients, and url to variables
    @IBAction func btnConfirmAction(_ sender: Any) {
        Shared.shared.recipe_ingredients = [String]()
        for recipe in get_recipes(cuisine: Shared.shared.selected_cuisine) {
            if (Shared.shared.recipe_chosen == recipe.name) {
                for ingredient in recipe.ingredients {
                    Shared.shared.recipe_ingredients.append(ingredient.name)
                    Shared.shared.amounts.append(ingredient.amount)
                    Shared.shared.measures.append(ingredient.measure)
                }
                Shared.shared.recipe_serving_size = recipe.serving_size
                Shared.shared.recipe_URL = recipe.url
                Shared.shared.recipe_instructions = recipe.instruction
                Shared.shared.recipe_tips = recipe.tip
            }
        }
    }
    
    // if analyze button is chosen, function grabs the weights of the recipes, and assigns them to variables
    @IBAction func analyzeBtn(_ sender: Any) {
        let cuisines = ["Japanese", "Korean", "Chinese", "Thai"]
        for cuisine in cuisines {
            for recipe in get_recipes(cuisine: cuisine) {
                for database_recipe in Shared.shared.recipe_database {
                    if (database_recipe[0] == recipe.name) {
                        Shared.shared.veg_weight_total = Shared.shared.veg_weight_total + Double(recipe.Veggie_Weight)!
                        Shared.shared.grain_weight_total = Shared.shared.grain_weight_total + Double(recipe.Grain_Weight)!
                        Shared.shared.meat_weight_total = Shared.shared.meat_weight_total + Double(recipe.Meat_Weight)!
                    }
                }
            }
        }
    }
    
    // function that searches the json files, and return recipes
    func get_recipes(cuisine:String) -> [Recipe] {
        if let path = Bundle.main.path(forResource: cuisine, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                return try decoder.decode([Recipe].self, from: data)
            }
            catch {
                fatalError("Recipe.json cannot be decoded")
            }
        }
        fatalError("Recipe.json does not exist")
    }
}
