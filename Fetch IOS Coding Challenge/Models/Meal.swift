//
//  Meal.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import Foundation

// Model representing a meal
struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}
