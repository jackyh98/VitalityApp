//
// DairyPopOverViewController.swift
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

class DairyPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // objects
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var dairy_ingredients: [String] = ["Butter", "Cream", "Cheese", "Coconut Milk","Milk", "Soy Milk", "Yogourt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
    }
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dairy_ingredients.count;
    }
    
    
    // Detects if a cell is selected in the table, if selected checkmark appears, and added to selected dairy in shared file
    // removes ingredient if checkmark is gone
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ( tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            if ( Shared.shared.dairy_selected_ingredients.contains( dairy_ingredients[indexPath.row] ) ) {
                Shared.shared.dairy_selected_ingredients.remove(at: Shared.shared.dairy_selected_ingredients.index(of: dairy_ingredients[indexPath.row])! )
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            Shared.shared.dairy_selected_ingredients.append(dairy_ingredients[indexPath.row ])
        }
        
        print("dairy Name : " + dairy_ingredients[indexPath.row])
        
    }
    
    // Displays the cells, as well as assign checkmarks to to previously selected ingredients if the viewcontroller is revisisted
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = dairy_ingredients[indexPath.row]
        if ( Shared.shared.dairy_selected_ingredients.contains((cell.textLabel?.text)!)) {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        if ( cell.accessoryType == UITableViewCellAccessoryType.checkmark && !Shared.shared.dairy_selected_ingredients.contains((cell.textLabel?.text)!)) {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    
    // Close PopUp
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

