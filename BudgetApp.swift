//
//  BudgetApp.swift
//  Budget
//
//  Created by Daniel Madjar on 12/26/23.
//

import SwiftUI

let height = UIScreen.main.bounds.height
let width = UIScreen.main.bounds.width

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
        }
    }
}
