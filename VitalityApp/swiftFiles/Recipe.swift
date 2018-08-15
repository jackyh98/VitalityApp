//  Recipe.swift
//  VitalityApp
//
//  CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Phillip Choi, Jacky Huynh, Jordan Cheung
//
// File created and worked on by Philip Choi

import Foundation

struct Recipe : Decodable {
    
    let name : String
    let url : String
    let ingredients : [Ingredient]
    let Veggie_Weight : String
    let Grain_Weight : String
    let Meat_Weight : String
    let instruction : String
    let tip : String
    let serving_size : String

    
    init(name : String, url: String, ingredients : [Ingredient], Veggie_Weight : String, Grain_Weight : String, Meat_Weight : String, instruction: String, tip: String, serving_size: String) {
        self.name = name
        self.url = url
        self.ingredients = ingredients
        self.Veggie_Weight = Veggie_Weight
        self.Grain_Weight = Grain_Weight
        self.Meat_Weight = Meat_Weight
        self.instruction = instruction
        self.tip = tip
        self.serving_size = serving_size
    }
    
    public var description: String { return name }
}
