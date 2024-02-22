//
//  MealView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/22/24.
//

import SwiftUI

struct MealView: View {
    let meal: Meal
    @Environment(ImageRepository.self) var imageRepository
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<CookbookImage>
    
    var body: some View {
        NavigationLink {
            RecipeView(meal: meal)
        } label: {
            Label {
                Text(meal.strMeal)
            } icon: {
                iconView
            }
        }
    }
    
    var iconView: some View {
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

#Preview {
    Group {
            MealView(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049"))
            MealView(meal: Meal(strMeal: "Apam balik", strMealThumb: "ProgressView Test", idMeal: "53049"))
    }
    .environment(ImageRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
