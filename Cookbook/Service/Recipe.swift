//
//  Recipe.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

struct Recipe: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var ingredients: [Ingredient] {
        var temp: [Ingredient] = []
        
        temp.append(Ingredient(id: "1", name: strIngredient1 ?? "", measurement: strMeasure1 ?? ""))
        temp.append(Ingredient(id: "2", name: strIngredient2 ?? "", measurement: strMeasure2 ?? ""))
        temp.append(Ingredient(id: "3", name: strIngredient3 ?? "", measurement: strMeasure3 ?? ""))
        temp.append(Ingredient(id: "4", name: strIngredient4 ?? "", measurement: strMeasure4 ?? ""))
        temp.append(Ingredient(id: "5", name: strIngredient5 ?? "", measurement: strMeasure5 ?? ""))
        temp.append(Ingredient(id: "6", name: strIngredient6 ?? "", measurement: strMeasure6 ?? ""))
        temp.append(Ingredient(id: "7", name: strIngredient7 ?? "", measurement: strMeasure7 ?? ""))
        temp.append(Ingredient(id: "8", name: strIngredient8 ?? "", measurement: strMeasure8 ?? ""))
        temp.append(Ingredient(id: "9", name: strIngredient9 ?? "", measurement: strMeasure9 ?? ""))
        temp.append(Ingredient(id: "10", name: strIngredient10 ?? "", measurement: strMeasure10 ?? ""))
        temp.append(Ingredient(id: "11", name: strIngredient11 ?? "", measurement: strMeasure11 ?? ""))
        temp.append(Ingredient(id: "12", name: strIngredient12 ?? "", measurement: strMeasure12 ?? ""))
        temp.append(Ingredient(id: "13", name: strIngredient13 ?? "", measurement: strMeasure13 ?? ""))
        temp.append(Ingredient(id: "14", name: strIngredient14 ?? "", measurement: strMeasure14 ?? ""))
        temp.append(Ingredient(id: "15", name: strIngredient15 ?? "", measurement: strMeasure15 ?? ""))
        temp.append(Ingredient(id: "16", name: strIngredient16 ?? "", measurement: strMeasure16 ?? ""))
        temp.append(Ingredient(id: "17", name: strIngredient17 ?? "", measurement: strMeasure17 ?? ""))
        temp.append(Ingredient(id: "18", name: strIngredient18 ?? "", measurement: strMeasure18 ?? ""))
        temp.append(Ingredient(id: "19", name: strIngredient19 ?? "", measurement: strMeasure19 ?? ""))
        temp.append(Ingredient(id: "20", name: strIngredient20 ?? "", measurement: strMeasure20 ?? ""))

        return temp
    }
}
