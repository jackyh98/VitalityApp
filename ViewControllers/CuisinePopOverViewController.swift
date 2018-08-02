//
// CuisinePopOverViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, Eric Lee, and Jordan Cheung
//

import UIKit

class CuisinePopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // objects
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // cuisines that can be selected
    var cuisines: [String] = ["Chinese", "Japanese", "Thai", "Korean"]
    
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
        return self.cuisines.count;
    }
    
    // Detects the selection of cells, if a cell is selected dismiss the viewcontroller, and update the shared file 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Cuisine : " + cuisines[indexPath.row])
        Shared.shared.selected_cuisine = cuisines[indexPath.row]
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cuisines[indexPath.row]
        return cell
    }
    
}
