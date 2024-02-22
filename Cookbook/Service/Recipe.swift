//
//  Recipe.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

struct Recipe: Decodable {
    let strMeal: String?
    let strInstructions: String?
    private(set) var ingredients: [Ingredient] = []
    
    enum CodingKeys: CodingKey {
        case strMeal
        case strInstructions
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient1),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure1),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "1", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient2),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure2),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "2", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient3),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure3),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "3", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient4),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure4),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "4", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient5),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure5),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "5", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient6),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure6),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "6", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient7),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure7),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "7", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient8),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure8),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "8", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient9),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure9),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "9", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient10),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure10),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "10", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient11),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure11),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "11", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient12),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure12),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "12", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient13),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure13),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "13", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient14),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure14),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "14", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient15),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure15),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "15", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient16),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure16),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "16", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient17),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure17),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "17", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient18),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure18),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "18", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient19),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure19),
           !ingredient.isEmpty {
            ingredients.append(Ingredient(id: "19", name: ingredient, measurement: measure))
        }
        
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient20),
           let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure20),
           !ingredient.isEmpty {
            
            ingredients.append(Ingredient(id: "20", name: ingredient, measurement: measure))
        }
    }
}
