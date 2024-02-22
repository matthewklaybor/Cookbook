//
//  MealView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import SwiftUI
import SwiftData

struct MealView: View {
    let mealCategory: MealCategory
    @Environment(CookbookRepository.self) var cookbookRepository
    @Environment(ImageRepository.self) var imageRepository
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<CookbookImage>
    
    var body: some View {
        @Bindable var cookbookRepository = cookbookRepository
        VStack {
            if let meals = cookbookRepository.meals[mealCategory.strCategory] {
                List(meals) { meal in
                    NavigationLink {
                        RecipeView(meal: meal)
                    } label: {
                        Label {
                            Text(meal.strMeal)
                        } icon: {
                            ZStack {
                                if let imageData = images.first(where: { $0.name == meal.strMealThumb })?.data, let image = UIImage(data: imageData) {
                                    Image(uiImage: image).resizable().scaledToFit()
                                } else {
                                    ProgressView()
                                        .task {
                                            if let data = await imageRepository.loadImage(url: meal.strMealThumb) {
                                                let image = CookbookImage(context: context)
                                                image.name = meal.strMealThumb
                                                image.data = data
                                                context.insert(image)
                                                try? context.save()
                                            }
                                        }
                                }
                            }
                        }
                    }
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
        Group {
            MealView(mealCategory: MealCategory(idCategory: "3",
                                            strCategory: "Dessert",
                                            strCategoryThumb: "https://www.themealdb.com/images/category/dessert.png",
                                            strCategoryDescription: "Dessert is a course that concludes a meal."))
            
            MealView(mealCategory: MealCategory(idCategory: "", strCategory: "ProgressView Test", strCategoryThumb: "", strCategoryDescription: ""))
        }
    }
    .environment(CookbookRepository())
    .environment(ImageRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
