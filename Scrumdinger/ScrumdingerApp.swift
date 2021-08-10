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
//                    .environment(\.realmConfiguration, Realm.Configuration(schemaVersion: 1))
                    .environment(\.realmConfiguration, Realm.Configuration(
                        schemaVersion: 2,
                        migrationBlock: { migration, oldSchemaVersion in
                            if oldSchemaVersion < 1 {
                                // Could init the `DailyScrum.isPublic` field here, but the default behavior of setting
                                // it to `false` is what we want.
                            }
                            if oldSchemaVersion < 2 {
                                migration.enumerateObjects(ofType: History.className()) { oldObject, newObject in
                                    let attendees = oldObject!["attendeeList"] as? RealmSwift.List<DynamicObject>
                                    newObject!["numberOfAttendees"] = attendees?.count ?? 0
                                }
                            }
                        }
                    ))
            }
        }
    }
}
