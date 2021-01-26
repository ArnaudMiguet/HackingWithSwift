//
//  Project11_BookwormApp.swift
//  Project11-Bookworm
//
//  Created by Arnaud Miguet on 26.01.21.
//

import SwiftUI

@main
struct Project11_BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
