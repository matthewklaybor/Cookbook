//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/14/24.
//

import SwiftUI

@main
struct CookbookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
