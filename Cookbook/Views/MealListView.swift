//
//  MealListView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import SwiftUI
import SwiftData

struct MealListView: View {
    let mealCategory: MealCategory
    @Environment(CookbookRepository.self) var cookbookRepository
    
    var body: some View {
        @Bindable var cookbookRepository = cookbookRepository
        VStack {
            if let meals = cookbookRepository.meals[mealCategory.strCategory] {
                List(meals) { meal in
                    MealView(meal: meal)
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await cookbookRepository.fetchMeals(category: mealCategory.strCategory)
        }
        .refreshable {
            await cookbookRepository.refreshMeals(category: mealCategory.strCategory)
        }
        .navigationTitle(mealCategory.strCategory)
        .alert(LocalizedStringKey("Error"), isPresented: $cookbookRepository.errorFetchingMeals, actions: {
            Button(LocalizedStringKey("Ok")) {}
            Button(LocalizedStringKey("Retry")) {
                Task { await cookbookRepository.fetchMeals(category: mealCategory.strCategory) }
            }
        }, message: {
            Text(LocalizedStringKey("serviceError"))
        })
    }
}

#Preview {
    NavigationStack {
        MealListView(mealCategory: MealCategory(idCategory: "3",
                                                strCategory: "Dessert",
                                                strCategoryThumb: "https://www.themealdb.com/images/category/dessert.png",
                                                strCategoryDescription: "Dessert is a course that concludes a meal."))
        
        MealListView(mealCategory: MealCategory(idCategory: "", strCategory: "Progress View / Error Test", strCategoryThumb: "", strCategoryDescription: ""))
    }
    .environment(CookbookRepository())
    .environment(ImageRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
