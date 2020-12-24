//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

class AppState: ObservableObject {
    let realm  = try! Realm()
    static var sample: AppState { AppState() }
}

@main
struct ScrumdingerApp: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView()
                    .environmentObject(state)
            }
        }
    }
}
