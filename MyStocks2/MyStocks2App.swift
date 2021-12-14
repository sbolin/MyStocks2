//
//  MyStocks2App.swift
//  MyStocks2
//
//  Created by Scott Bolin on 16-May-21.
//

import SwiftUI

@main
struct MyStocks2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
