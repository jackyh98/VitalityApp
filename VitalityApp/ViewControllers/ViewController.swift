//
// ViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File created by Eric Joseph Lee, Jacky Huynh
//
// Bugs(fixed): Variables would not be resetted when revisiting this viewController, uibarbuttonitems were not working as intended

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var databaseHandle:DatabaseHandle?
    
    // objects buttons on viewcontroller
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var logoutBtnLabel: UIButton!
    
    //logout button action function
    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "username")
        loginBtn.setTitle("Login", for: .normal)
        logoutBtnLabel.isHidden = true
    }
    
    @IBAction func historyBtn(_ sender: Any) {
        
        if (UserDefaults.standard.object(forKey: "username") == nil ) {
            createAlert(title: "Login is Required", message: "Please Login")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checks if users have a saved username, if they do then fetch their saved recipes and save it to a variable in the shared file
        if (UserDefaults.standard.object(forKey: "username") != nil) {
            databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
                let database_recipe = snapshot.value as? [String]
                let data = database_recipe
                if (!Shared.shared.recipe_database.contains(data!)) {
                            Shared.shared.recipe_database.append(data!)
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // if users have a saved username then the login button is the users username, and make the logout button visible
        if let user = UserDefaults.standard.object(forKey: "username") as? String {
            logoutBtnLabel.isHidden = false
            logoutBtnLabel.setTitle("Logout", for: .normal)
            loginBtn.setTitle(user, for: .normal)
        }
        // otherwise make the logout button hidden, and the login button "Login"
        else {
            logoutBtnLabel.isHidden = true
            loginBtn.setTitle("Login", for: .normal)
        }
 
        // resets all shared file variables when revisiting this viewcontroller
        Shared.shared.selected_cuisine = "---------"
        Shared.shared.veg_selected_ingredients = [String]()
        Shared.shared.meat_selected_ingredients = [String]()
        Shared.shared.grain_selected_ingredients = [String]()
        Shared.shared.dairy_selected_ingredients = [String]()
        Shared.shared.recipe_database = [[String]]()
        Shared.shared.recipe_chosen = nil
        Shared.shared.recipe_ingredients = [String]()
        Shared.shared.recipe_URL = nil
        Shared.shared.recipe_database = [[String]]()
        Shared.shared.veg_weight_total = 0
        Shared.shared.grain_weight_total = 0
        Shared.shared.meat_weight_total  = 0
        Shared.shared.amounts = [String]()
        Shared.shared.measures = [String]()
        Shared.shared.recipe_instructions = ""
        Shared.shared.recipe_tips = ""
        Shared.shared.recipe_serving_size = ""
        
        // if users are logged in then grab all their saved recipes from the database and save recipe_database in the shared file
        if (UserDefaults.standard.object(forKey: "username") != nil) {
            databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
                let database_recipe = snapshot.value as? [String]
                let data = database_recipe
                
                if (!Shared.shared.recipe_database.contains(data!)) {
                    Shared.shared.recipe_database.append(data!)
                }
                
            })
        }
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
