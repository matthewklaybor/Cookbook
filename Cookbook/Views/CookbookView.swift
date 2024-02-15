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
            List(cookbookRepository.categories) { category in
                CategoryView(category: category)
            }
            .navigationTitle(Text(LocalizedStringKey("Cookbook")))
            .listStyle(.grouped)
            .refreshable {
                await cookbookRepository.refreshCategories()
            }
            .alert(LocalizedStringKey("Error"), isPresented: $cookbookRepository.errorFetchingCategories, actions: {
                Button(LocalizedStringKey("Ok"), role: .cancel, action: {})
                Button(LocalizedStringKey("Retry")) {
                    Task { await cookbookRepository.refreshCategories() }
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
        .environment(MediaRepository())
        .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
