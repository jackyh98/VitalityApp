//
//  HistoryRecipeViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-23.
//
// Bugs(fixed): Images would not get download/upload to/from the database

import UIKit
import FirebaseStorage
import FirebaseDatabase

class HistoryRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // objects in the viewController
    @IBOutlet var recipeImageView: UIImageView!
    
    //@IBOutlet var btnURLlabel: UIButton!
    
    
    @IBOutlet var btnURLlabel: UILabel!
    
    @IBOutlet var ingredients_list: UITextView!
    @IBOutlet var btnUpload: UIButton!
    @IBOutlet var link_label: UIButton!
    
    // grabbing the appropriate variables needed from the shared file
    var recipe:String = Shared.shared.recipe_chosen
    var ingredients = Shared.shared.recipe_ingredients
    var recipe_URL:String = Shared.shared.recipe_URL
    var cuisine:String = Shared.shared.selected_cuisine
    var imageURL:String = ""
    var amounts = Shared.shared.amounts
    var measures = Shared.shared.measures
    var recipe_instructions = Shared.shared.recipe_instructions
    var recipe_tips = Shared.shared.recipe_tips
    var recipe_serving_size = Shared.shared.recipe_serving_size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var databaseHandle:DatabaseHandle
        
        // auto resize font when string is too long
        btnURLlabel.adjustsFontSizeToFitWidth = true
        
        // make link invisible if there is no link involved with recipe
        if (recipe_URL == "") {
            link_label.isHidden = true
        }
        
        // sets the button title
        btnURLlabel.text = recipe
        
        // Prints out all the recipe informations
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
        
        // goes to the database and goes to the child according to the users username
        databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            let data = database_recipe
            
            // checks if the data contains a url and matches the recipe that users have chosen
            // if so download the data and display it in the image view
            // initially set the upload button to loading, and afterwards change it to ""
            if (data!.count == 3 && data![0] == self.recipe) {
                self.btnUpload.setTitle("LOADING", for: .normal)
                self.imageURL = data![2]
                
                let url = URL(string: self.imageURL)
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    if (error != nil) {
                        print("error geting url")
                        return
                    }
                    DispatchQueue.main.async {
                        self.recipeImageView?.image = UIImage(data: data!)
                        self.btnUpload.backgroundColor = UIColor.clear
                        self.btnUpload.setTitle("", for: .normal)
                    }
                }.resume()
            }
        })
    }
    
    // if the recipe image button is clicked, allow users to pick the image they want to display
    @IBAction func recipeImageBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // function that calls that gets the image that users have picked, and assigns to it to the imageview
    // as well as uploading it to the database, and getting the url and saving it
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageName = NSUUID().uuidString
        
        // variable to hold users selected image
        var selectedImageFromPicker: UIImage?
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        let rootRef = Database.database().reference()

        // if users edits an image assign the edited image to selectedimage
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        // if users just use original image assign that to selectedimage
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        // displays users selected image in the imageview
        if let selectedImage = selectedImageFromPicker {
            recipeImageView.image = selectedImage
            btnUpload.backgroundColor = UIColor.clear
            btnUpload.setTitle("", for: .normal)
        }
        
        // uploads users selected image to the databse for future reference
        if let uploadData = UIImagePNGRepresentation(recipeImageView.image!) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    print("error uploading")
                    return
                }
                print("uploaded")
                
                // gets the url of the uploaded image, and assigns it to the right childs of the user, and recipe
                storageRef.downloadURL(completion: { (url, error) in
                    rootRef.child((UserDefaults.standard.object(forKey: "username") as? String)!).child(self.recipe).setValue([self.recipe, self.cuisine,  url!.absoluteString])
                })
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // if users press cancel on the imagepickercontroller dismiss the view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    // if users press the url button, it open safari with the recipe url
    @IBAction func btnURL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    // if users press the home button take them back to the rootViewController
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

