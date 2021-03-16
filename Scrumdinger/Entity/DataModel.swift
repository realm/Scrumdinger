//
//  DataModel.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import Combine
import SwiftUI
import RealmSwift

final class DataModel {
    @Published var scrums = [DailyScrum]()
    
    func load() {
        let realm = try! Realm()
        scrums = Array(realm.objects(DailyScrum.self))
    }
    
    func pushNewScrum(title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = [History]()) {
        let scrum = DailyScrum(title: title, attendees: attendees, lengthInMinutes: lengthInMinutes, color: color, history: history)
        scrums.append(scrum)
    }
}

/// Extension for SwiftUI previews
#if DEBUG
extension DataModel {
    convenience init(_ scrums: [DailyScrum]) {
        self.init()
        self.scrums = scrums
    }
    
    static var sample = DataModel (
        [
            DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, color: Color.random),
            DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, color: Color.random),
            DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 1, color: Color.random)
        ]
    )
//    private static var random: Double { Double.random(in: 0...1) }
//    private static var randomComponents: Components { Components(red: random, green: random, blue: random, alpha: random) }
}
#endif
