//
// VegPopOverViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, Eric Lee, and Jordan Cheung
//
// Bugs(fixed): selected ingredients were not checkmarked, checkmarks were not saved when returning to view controller to change selected ingredients, cells were being recycled so unchecked cells would become checked after scrolling

import UIKit

class VegPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // ingredients that can be selected
    var veg_ingredients: [String] = ["Asparagus", "Avacado","Bamboo Shoots", "Banana","Basil", "Bean - Black", "Bean - Chinese Long", "Bean - Green", "Bean - Sprout", "Bean sprouts", "Beet", "Bok Choy", "Broccoli", "Broccoli Florets", "Cabbage", "Cabbage - Green", "Cabbage - Napa", "Cabbage - Red", "Carrot", "Cauliflower", "Celery", "Cilantro", "Corn", "Corn - Baby", "Cucumber", "Edamame","Eggplant - Asian", "Garlic", "Ginger", "Ginger Pickle", "Green Beans", "Kaffir Lime Leaves" ,"Kale", "Lemon", "Lettuce - Butter", "Lettuce - Green", "Lime", "Lily Buds", "Mint", "Mushroom - Chinese Black Fungus", "Mushroom - Crimini", "Mushroom - Enoki", "Mushroom - Oyster", "Mushroom - Pleurotus Eryngii", "Mushroom - Pholiota Nameko", "Mushroom - Enokitake","Mushroom - Shiitake","Mushroom - Wood Ear",  "Mushroom - White", "Mushroom - Mixed", "Nuts - Almond", "Nuts - Cashew", "Nuts - Peanut", "Onion - Green", "Onion - Medium", "Onion - Red", "Onion - White", "Pea", "Pea - Snap", "Pea - Snow", "Pea - Sweet", "Pepper - Cayenne", "Pepper - Chili", "Pepper - Dried Red Chili", "Pepper - Red Chili Powder", "Pepper - Red Chili", "Pepper - Green Bell", "Pepper - Orange Bell", "Pepper - Red Bell", "Pepper - Yellow Bell", "Peppercorn - Sichuan", "Pineapple", "Radish", "Red Dates", "Spanich", "Seaweed", "Sesame Seed", "Squash","Squash - Zucchini", "Squash - Butternut", "Thai Basil", "Thai Chili","Tomato", "Tomato Paste", "Wakame", "Water Chestnut"]
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        //Popupview.layer.masksToBounds = true
    }
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.veg_ingredients.count;
    }
    
    // Detects if a cell is selected in the table, if selected checkmark appears, and added to selected vegetables in shared file
    // removes ingredient if checkmark is gone
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            if ( Shared.shared.veg_selected_ingredients.contains( veg_ingredients[indexPath.row] ) ) {
                Shared.shared.veg_selected_ingredients.remove(at: Shared.shared.veg_selected_ingredients.index(of: veg_ingredients[indexPath.row])! )
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            Shared.shared.veg_selected_ingredients.append(veg_ingredients[indexPath.row])
        }
        
        print("Veg Name : " + veg_ingredients[indexPath.row])
    }
    
    // Displays the cells, as well as assign checkmarks to to previously selected ingredients if the viewcontroller is revisisted
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        cell.textLabel?.text = veg_ingredients[indexPath.row]
        
        if ( Shared.shared.veg_selected_ingredients.contains((cell.textLabel?.text)!)) {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        if ( cell.accessoryType == UITableViewCellAccessoryType.checkmark && !Shared.shared.veg_selected_ingredients.contains((cell.textLabel?.text)!)) {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    
    // Close PopUp
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

