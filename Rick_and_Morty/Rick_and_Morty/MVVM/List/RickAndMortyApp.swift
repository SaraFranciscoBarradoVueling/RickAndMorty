//
//  Rick_and_MortyApp.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RickAndMortyList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
