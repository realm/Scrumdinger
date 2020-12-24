//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

@main
struct ScrumdingerApp: SwiftUI.App {
    @ObservedObject private var data = ScrumData()
    let realm = try! Realm()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
