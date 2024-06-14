//
//  MealDetail.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import Foundation

// Model representing detailed information about a meal
struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let ingredients: [Ingredient]
    
    // Model representing an ingredient with its measurement
    struct Ingredient: Codable {
        let name: String
        let measure: String
    }
    
    // Custom initializer with default values
    init(idMeal: String = "", strMeal: String = "", strMealThumb: String = "", strInstructions: String = "", ingredients: [Ingredient] = []) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strInstructions = strInstructions
        self.ingredients = ingredients
    }
    
    // DynamicCodingKey allows dynamic key construction
    private struct DynamicCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int? = nil
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    // Custom decoding to handle dynamic keys for ingredients and measures
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        // Use a container keyed by DynamicCodingKey
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        var tempIngredients: [Ingredient] = []
        var seenIngredients = Set<String>()
        
        for i in 1...20 {
            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(i)")
            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(i)")
            
            if let ingredientKey = ingredientKey, let measureKey = measureKey {
                let name = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey)
                let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey)
                
                if let name = name, !name.isEmpty, let measure = measure, !measure.isEmpty {
                    if !seenIngredients.contains(name) {
                        tempIngredients.append(Ingredient(name: name, measure: measure))
                        seenIngredients.insert(name)
                    }
                }
            }
        }
        ingredients = tempIngredients
    }
}
