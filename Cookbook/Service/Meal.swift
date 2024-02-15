//
//  Meal.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

extension Meal: Identifiable {
    var id: String { idMeal }
}

extension Meal: Comparable {
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        lhs.strMeal < rhs.strMeal
    }
}
