//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import RealmSwift
import SwiftUI

class DailyScrum: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    let attendeeList = RealmSwift.List<String>()
    @objc dynamic var lengthInMinutes = 0
    @objc dynamic var colorComponents: Components?
    let historyList = RealmSwift.List<History>()
    
    var color: Color { Color(colorComponents ?? Components()) }
    var attendees: [String] { Array(attendeeList) }
    var history: [History] { Array(historyList) }
    
    convenience init(title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = []) {
        self.init()
        self.title = title
        for attendee in attendees {
            self.attendeeList.append(attendee)
        }
        self.lengthInMinutes = lengthInMinutes
        self.colorComponents = color.components
        for entry in history {
            self.historyList.insert(entry, at: 0)
        }
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
        return Data(title: title, attendees: Array(attendees), lengthInMinutes: Double(lengthInMinutes), color: color)
    }
    
    func update(from data: Data) {
        title = data.title
        for attendee in attendees {
            self.attendeeList.append(attendee)
        }
        lengthInMinutes = Int(data.lengthInMinutes)
        colorComponents = data.color.components
    }
}

