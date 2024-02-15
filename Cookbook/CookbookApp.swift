//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/12/24.
//

import SwiftUI
import SwiftData

@main
struct CookbookApp: App {
    @State private var persistentContainer = PersistentContainer()
    
    //SwiftData performance is not as good as CoreData, I left commented out code in place.
    /* var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CookbookMedia.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }() */
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { output in
                    persistentContainer.deleteAll()
//                    sharedModelContainer.deleteAllData()
                }
        }
//        .modelContainer(sharedModelContainer)
    }
}
