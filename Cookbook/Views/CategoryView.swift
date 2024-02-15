//
//  CategoryView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    let category: MealCategory
    @Environment(CookbookRepository.self) var cookbookRepository
    @Environment(MediaRepository.self) var mediaRepository
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<CookbookMedia>
    //    @Environment(\.modelContext) private var modelContext
    //    @Query private var images: [CookbookMedia]
    
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
            MealView(category: category)
        } label: {
            ZStack {
                if let imageData = images.first(where: { $0.name == category.strCategoryThumb })?.image, let image = UIImage(data: imageData) {
                    Image(uiImage: image).resizable().scaledToFit()
                } else {
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .overlay(alignment: .center) {
                            ProgressView()
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(40)
                        .task {
                            if let data = await mediaRepository.loadImage(url: category.strCategoryThumb) {
                                let media = CookbookMedia(context: context)
                                media.name = category.strCategoryThumb
                                media.image = data
                                context.insert(media)
                                try? context.save()
                                //modelContext.insert(CookbookMedia(name: category.strCategoryThumb, image: data))
                            }
                        }
                }
            }
            .background {
                imageBackground
            }
            .overlay(alignment: .topLeading) {
                Text(category.strCategory)
                    .bold()
                    .font(.title)
                    .padding()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    }
    
    // AsyncImageView without CoreData
     /* var body: some View {
        NavigationLink {
            MealView(category: category)
        } label: {
            ZStack {
                if let image = mediaRepository.imageCache(name: category.strCategoryThumb) {
                    image.resizable().scaledToFit()
                } else {
                    AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                        image.resizable()
                            .scaledToFit()
                            .onDisappear {
                                mediaRepository.storeImage(image: image, name: category.strCategoryThumb)
                            }
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .overlay(alignment: .center) {
                                ProgressView()
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(40)
                    }
                }
            }
            .background {
                imageBackground
            }
            .overlay(alignment: .topLeading) {
                Text(category.strCategory)
                    .bold()
                    .font(.title)
                    .padding()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    } */
}

#Preview {
    Group {
        CategoryView(category: MealCategory(idCategory: "1",
                                            strCategory: "Beef",
                                            strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
                                            strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."))
        
        CategoryView(category: MealCategory(idCategory: "1",
                                            strCategory: "Beef",
                                            strCategoryThumb: "loading",
                                            strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."))
    }
    .environment(CookbookRepository())
    .environment(MediaRepository())
    .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
//    .modelContainer(for: CookbookMedia.self, inMemory: true)
}
