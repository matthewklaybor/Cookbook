//
//  CookbookView.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI

struct CookbookView: View {
    @Environment(CookbookRepository.self) var cookbookRepository
    
    var body: some View {
        @Bindable var cookbookRepository = cookbookRepository
        NavigationStack {
            List(cookbookRepository.mealCategories) { mealCategory in
                MealCategoryView(mealCategory: mealCategory)
            }
            .navigationTitle(Text(LocalizedStringKey("Cookbook")))
            .listStyle(.grouped)
            .refreshable {
                await cookbookRepository.refreshMealCategories()
            }
            .alert(LocalizedStringKey("Error"), isPresented: $cookbookRepository.errorFetchingMealCategories, actions: {
                Button(LocalizedStringKey("Ok"), role: .cancel, action: {})
                Button(LocalizedStringKey("Retry")) {
                    Task { await cookbookRepository.refreshMealCategories() }
                }
            }, message: {
                Text(LocalizedStringKey("serviceError"))
            })
        }
    }
}

#Preview {
    CookbookView()
        .environment(CookbookRepository())
        .environment(ImageRepository())
        .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
