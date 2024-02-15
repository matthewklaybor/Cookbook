//
//  MealCategory.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

struct MealCategory: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

extension MealCategory: Identifiable {
    var id: String { idCategory }
}

extension MealCategory: Comparable {
    static func < (lhs: MealCategory, rhs: MealCategory) -> Bool {
        lhs.strCategory < rhs.strCategory
    }
}
