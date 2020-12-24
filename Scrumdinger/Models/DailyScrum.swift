//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import RealmSwift
import SwiftUI

class DailyScrum: Object, Identifiable {
    @objc dynamic var id: UUID
    @objc dynamic var title: String
    let attendees = RealmSwift.List<String>()
    @objc dynamic var lengthInMinutes: Int
    @objc dynamic var color: Components
    var history: [History]
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = []) {
        self.id = id
        self.title = title
        for attendee in attendees {
            self.attendees.append(attendee)
        }
        self.lengthInMinutes = lengthInMinutes
        self.color = color.components
        self.history = history
        }
}

extension DailyScrum {
    static var data: [DailyScrum] {
        [
            DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, color: Color("Design")),
            DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, color: Color("App Dev")),
            DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 1, color: Color("Web Dev"))
        ]
    }
}

extension DailyScrum {
    struct Data {
        var title: String = ""
        var attendees: [String] = []
        var lengthInMinutes: Double = 5.0
        var color: Color = .random
    }

    var data: Data {
        return Data(title: title, attendees: Array(attendees), lengthInMinutes: Double(lengthInMinutes), color: Color(color))
    }
    
    func update(from data: Data) {
        title = data.title
        for attendee in attendees {
            self.attendees.append(attendee)
        }
        lengthInMinutes = Int(data.lengthInMinutes)
        color = data.color.components
    }
}

