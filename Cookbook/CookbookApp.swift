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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { output in
                    persistentContainer.deleteAll()
                }
        }
    }
}
