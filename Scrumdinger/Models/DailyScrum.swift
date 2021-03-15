//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import RealmSwift
import SwiftUI

@objcMembers class DailyScrum: Object, ObjectKeyIdentifiable {
    dynamic var title = ""
    var attendees = RealmSwift.List<String>()
    dynamic var lengthInMinutes = 0
    dynamic var colorComponents: Components?
    var history = RealmSwift.List<History>()
    
    var color: Color { Color(colorComponents ?? Components()) }

    convenience init(title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = []) {
        self.init()
        self.title = title
        self.attendees.append(objectsIn: attendees)
        self.lengthInMinutes = lengthInMinutes
        self.colorComponents = color.components
        for entry in history {
            self.history.insert(entry, at: 0)
        }
    }

    convenience init(viewModel: DailyScrumViewModel) {
        self.init()

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
    func update(from viewModel: DailyScrumViewModel) {
        title = viewModel.title
        for attendee in viewModel.attendees {
            if !attendees.contains(attendee) {
                self.attendees.append(attendee)
            }
        }
        lengthInMinutes = Int(viewModel.lengthInMinutes)
        colorComponents = viewModel.color.components
    }
}

