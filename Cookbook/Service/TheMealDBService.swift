//
//  TheMealDBService.swift
//  CookbookApp
//  TheMealDB Recipe API: https://themealdb.com/api.php
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

protocol TheMealDBServiceProtocol {
    func fetchCategories() async -> Result<MealCategoryResponse, ServiceError>
    func fetchMeals(category: String) async -> Result<MealResponse, ServiceError>
    func fetchRecipe(mealId: String) async -> Result<RecipeResponse, ServiceError>
}

class TheMealDBService: ServiceClient, TheMealDBServiceProtocol {
    private let baseUrl = "https://themealdb.com/api/json/v1/1/"
    
    func fetchCategories() async -> Result<MealCategoryResponse, ServiceError> {
        await get(url: baseUrl + "categories.php")
    }
    
    func fetchMeals(category: String) async -> Result<MealResponse, ServiceError> {
        await get(url: baseUrl + "filter.php?c=\(category)")
    }
    
    func fetchRecipe(mealId: String) async -> Result<RecipeResponse, ServiceError> {
        await get(url: baseUrl + "lookup.php?i=\(mealId)")
    }
}
