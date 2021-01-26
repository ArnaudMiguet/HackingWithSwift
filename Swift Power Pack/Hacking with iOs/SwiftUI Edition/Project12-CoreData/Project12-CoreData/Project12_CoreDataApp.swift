//
//  Project12_CoreDataApp.swift
//  Project12-CoreData
//
//  Created by Arnaud Miguet on 26.01.21.
//

import SwiftUI

@main
struct Project12_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
