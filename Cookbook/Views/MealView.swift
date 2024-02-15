//
//  MealView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import SwiftUI
import SwiftData

struct MealView: View {
    let category: MealCategory
    @Environment(CookbookRepository.self) var cookbookRepository
    @Environment(MediaRepository.self) var mediaRepository
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<CookbookMedia>
//    @Environment(\.modelContext) private var modelContext
//    @Query private var images: [CookbookMedia]
    
    var body: some View {
        @Bindable var cookbookRepository = cookbookRepository
        VStack {
            if let meals = cookbookRepository.meals[category.strCategory] {
                List(meals) { meal in
                    NavigationLink {
                        RecipeView(meal: meal)
                    } label: {
                        Label {
                            Text(meal.strMeal)
                        } icon: {
                            ZStack {
                                if let imageData = images.first(where: { $0.name == meal.strMealThumb })?.image, let image = UIImage(data: imageData) {
                                    Image(uiImage: image).resizable().scaledToFit()
                                } else {
                                    ProgressView()
                                        .task {
                                            if let data = await mediaRepository.loadImage(url: meal.strMealThumb) {
                                                let media = CookbookMedia(context: context)
                                                media.name = meal.strMealThumb
                                                media.image = data
                                                context.insert(media)
                                                try? context.save()
                                                //modelContext.insert(CookbookMedia(name: meal.strMealThumb, image: data))
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
            await cookbookRepository.fetchMeals(category: category.strCategory)
        }
        .refreshable {
            await cookbookRepository.refreshMeals(category: category.strCategory)
        }
        .navigationTitle(category.strCategory)
        .alert(LocalizedStringKey("Error"), isPresented: $cookbookRepository.errorFetchingMeals, actions: {
            Button(LocalizedStringKey("Dismiss")) {}
            Button(LocalizedStringKey("Retry")) {
                Task { await cookbookRepository.fetchMeals(category: category.strCategory) }
            }
        }, message: {
            Text(LocalizedStringKey("serviceError"))
        })
    }
    
     // AsyncImageView without CoreData
        /* var body: some View {
            VStack {
                if let meals = cookbookRepository.meals[category.strCategory] {
                    List(meals) { meal in
                        NavigationLink {
                            RecipeView(meal: meal)
                        } label: {
                            Label {
                                Text(meal.strMeal)
                            } icon: {
                                ZStack {
                                    if let image = mediaRepository.imageCache(name: meal.strMealThumb) {
                                        image.resizable().scaledToFit()
                                    } else {
                                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .onDisappear {
                                                    mediaRepository.storeImage(image: image, name: meal.strMealThumb)
                                                }
                                        } placeholder: {
                                            ProgressView()
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
                await cookbookRepository.fetchMeals(category: category.strCategory)
            }
            .refreshable {
                await cookbookRepository.refreshMeals(category: category.strCategory)
            }
            .navigationTitle(category.strCategory)
        } */
}

#Preview {
    NavigationStack {
        Group {
            MealView(category: MealCategory(idCategory: "3",
                                            strCategory: "Dessert",
                                            strCategoryThumb: "https://www.themealdb.com/images/category/dessert.png",
                                            strCategoryDescription: "Dessert is a course that concludes a meal."))
            
            MealView(category: MealCategory(idCategory: "", strCategory: "ProgressView Test", strCategoryThumb: "", strCategoryDescription: ""))
        }
    }
    .environment(CookbookRepository())
    .environment(MediaRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
//    .modelContainer(for: CookbookMedia.self, inMemory: true)
}
