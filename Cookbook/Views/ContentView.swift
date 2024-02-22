//
//  ContentView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cookbookRepository = CookbookRepository()
    @State private var imageRepository = ImageRepository()
    
    var body: some View {
        VStack {
            if cookbookRepository.isInitialized {
                CookbookView()
                    .environment(cookbookRepository)
                    .environment(imageRepository)
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
            } else {
                SplashView()
            }   
        }
        .task {
            await cookbookRepository.initialize()
        }
        .alert(LocalizedStringKey("Error"), isPresented: $cookbookRepository.initializationErrorOccurred, actions: {
            Button(LocalizedStringKey("Ok"), role: .cancel, action: {})
            
            Button(LocalizedStringKey("Retry")) {
                Task { await cookbookRepository.initialize() }
            }
        }, message: {
            Text(LocalizedStringKey("initializationErrorMessage"))
        })
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
