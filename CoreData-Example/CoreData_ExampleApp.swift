//
//  CoreData_ExampleApp.swift
//  CoreData-Example
//
//  Created by ukseung.dev on 8/30/24.
//

import SwiftUI

@main
struct CoreData_ExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
