//
//  Shared.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//


import Foundation

final class Shared {
    static let shared = Shared()
    
    // variables that all view controllers can access
    var amounts = [String]()
    var measures = [String]()
    var recipe_instructions:String = ""
    var recipe_tips:String = ""
    var recipe_serving_size:String = ""
    
    // variables for the history tab
    var recipe_chosen:String!
    var recipe_ingredients = [String]()
    var recipe_URL:String!
    var recipe_database = [[String]]()
    var veg_weight_total : Double = 0
    var grain_weight_total : Double = 0
    var meat_weight_total : Double = 0
    
    // variables for the create plate tab
    var selected_cuisine:String!
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
}

