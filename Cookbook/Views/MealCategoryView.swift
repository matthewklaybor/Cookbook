//
//  MealCategoryView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI
import CoreData

struct MealCategoryView: View {
    let mealCategory: MealCategory
    @Environment(CookbookRepository.self) var cookbookRepository
    @Environment(ImageRepository.self) var imageRepository
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<CookbookImage>
    
    private let imageBackground = LinearGradient(
        colors: [
            Color.black.opacity(0.33),
            Color.white.opacity(0.17),
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        NavigationLink {
            MealListView(mealCategory: mealCategory)
        } label: {
            mealCategoryLabel
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    }
    
    var mealCategoryLabel: some View {
        ZStack {
            imageBackground
                .overlay(alignment: .topLeading) {
                    Text(mealCategory.strCategory)
                        .bold()
                        .font(.title)
                        .padding()
                }
            if let imageData = images.first(where: { $0.name == mealCategory.strCategoryThumb })?.data, let image = UIImage(data: imageData) {
                Image(uiImage: image).resizable().scaledToFit()
            } else {
                imageLoadingView
            }
        }
    }
    
    var imageLoadingView: some View {
        Rectangle()
            .foregroundStyle(Color.clear)
            .overlay(alignment: .center) {
                ProgressView()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(40)
            .task {
                if let data = await imageRepository.loadImage(url: mealCategory.strCategoryThumb) {
                    let image = CookbookImage(context: context)
                    image.name = mealCategory.strCategoryThumb
                    image.data = data
                    context.insert(image)
                    try? context.save()
                }
            }
    }
}

#Preview {
    NavigationStack {
        MealCategoryView(mealCategory: MealCategory(idCategory: "1",
                                                    strCategory: "Beef",
                                                    strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
                                                    strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."))
        
        
        MealCategoryView(mealCategory: MealCategory(idCategory: "1",
                                                    strCategory: "Beef",
                                                    strCategoryThumb: "loading",
                                                    strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."))
    }
    .environment(CookbookRepository())
    .environment(ImageRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
