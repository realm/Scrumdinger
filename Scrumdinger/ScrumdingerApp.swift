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
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView()
                    .environment(\.realmConfiguration, Realm.Configuration(
                        schemaVersion: 2
//                        migrationBlock: { migration, oldSchemaVersion in
//                            if oldSchemaVersion < 2 {
//                                // The enumerateObjects(ofType:_:) method iterates over
//                                // every Person object stored in the Realm file
//                                migration.enumerateObjects(ofType: DailyScrum.className()) { oldObject, newObject in
//                                    // combine name fields into a single field
//                                    newObject!["extraSeconds"] = 72
//                                }
//                            }
//                    }
                ))
            }
        }
    }
}
