//
//  CookbookRepository.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI

@Observable
class CookbookRepository {
    private let recipeService = TheMealDBService()
    
    var initializationErrorOccurred: Bool = false
    var errorFetchingCategories: Bool = false
    var errorFetchingMeals: Bool = false
    var errorFetchingRecipe: Bool = false
    private(set) var isInitialized: Bool = false
    private(set) var categories: [MealCategory] = []
    private(set) var meals: [String: [Meal]] = [:]
    private(set) var recipes: [String: [Recipe]] = [:]
    
    func initialize() async {
        let result = await recipeService.fetchCategories()
        
        switch result {
        case .success(let response): 
            categories = response.categories.sorted()
            isInitialized = true
            initializationErrorOccurred = false
        case .failure(_):
            initializationErrorOccurred = true
        }
    }
    
    func refreshCategories() async {
        let result = await recipeService.fetchCategories()
        
        switch result {
        case .success(let response):
            categories = response.categories.sorted()
            meals.removeAll()
            recipes.removeAll()
        case .failure(_):
            errorFetchingCategories.toggle()
        }
    }
    
    func fetchMeals(category: String) async {
        guard !meals.keys.contains(category) else {
            return
        }
        
        let result = await recipeService.fetchMeals(category: category)
        
        switch result {
        case .success(let response):
            meals[category] = response.meals.sorted()
            meals = meals
        case .failure(_):
            errorFetchingMeals.toggle()
        }
    }
    
    func refreshMeals(category: String) async {
        let result = await recipeService.fetchMeals(category: category)
        
        switch result {
        case .success(let response):
            removeRecipes(category: category)
            meals[category] = response.meals.sorted()
        case .failure(_):
            errorFetchingMeals.toggle()
        }
    }
    
    func fetchRecipe(mealId: String) async {
        guard !recipes.keys.contains(mealId) else {
            return
        }
        
        let result = await recipeService.fetchRecipe(mealId: mealId)
        
        switch result {
        case .success(let response):
            recipes[mealId] = response.recipes
        case .failure(_):
            errorFetchingRecipe.toggle()
        }
    }
    
    private func removeRecipes(category: String) {
        meals[category]?.forEach({ meal in
            recipes.removeValue(forKey: meal.idMeal)
        })
    }
}
