//
//  ContentView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cookbookRepository = CookbookRepository()
    @State private var mediaRepository = MediaRepository()
    
    var body: some View {
        VStack {
            if cookbookRepository.isInitialized {
                CookbookView()
                    .environment(cookbookRepository)
                    .environment(mediaRepository)
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
            } else {
                SplashView()
            }   
        }
        .task {
            await cookbookRepository.initialize()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistentContainer().container.viewContext)
}
