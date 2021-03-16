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
    dynamic var lengthInMinutes = 0
    private dynamic var colorComponents: Components?
    private var attendeeList = RealmSwift.List<String>()
    private var historyList = RealmSwift.List<History>()
    
//    var color: Color { Color(colorComponents ?? Components()) }
    var attendees: [String] {
        get {
            Array(attendeeList)
        }
        set(newAttendees) {
            let realm = try! Realm()
            try! realm.write {
                attendeeList.removeAll()
                attendeeList.append(objectsIn: newAttendees)
            }
        }
    }
    var history: [History] {
        get {
            Array(historyList)
        }
        set(newHistory) {
            let realm = try! Realm()
            try! realm.write {
                historyList.removeAll()
                historyList.append(objectsIn: newHistory)
            }
        }
    }
    var color: Color {
        get {
            Color(colorComponents ?? Components())
        }
        set (color) {
            colorComponents = color.components
        }
    }
    
//    private static func attendeeArrayToList(_ array: [String]) -> List<String> {
//        let attendees = RealmSwift.List<String>()
//        attendees.append(objectsIn: array)
//        return attendees
//    }

    convenience init(title: String, attendees: RealmSwift.List<String>, lengthInMinutes: Int, color: Components, history: RealmSwift.List<History> = RealmSwift.List<History>()) {
        self.init()
        self.title = title
        self.attendeeList =  attendees
        self.lengthInMinutes = lengthInMinutes
        self.colorComponents = color
        self.historyList = history
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    convenience init(title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = [History]()) {
        self.init()
        self.title = title
        self.attendees =  attendees
        self.lengthInMinutes = lengthInMinutes
        self.color = color
        self.history = history
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    func updateTitle(_ title: String) {
        let realm = try! Realm()
        try! realm.write {
            self.title = title
        }
    }
    
    func updateDuration(_ duration: Int) {
        let realm = try! Realm()
        try! realm.write {
            self.lengthInMinutes = duration
        }
    }
    
    func updateColor(_ color: Color) {
        let realm = try! Realm()
        try! realm.write {
            self.color = color
        }
    }
    
    func addToHistory(_ entry: History) {
        self.historyList.insert(entry, at: 0)
    }

}

//extension DailyScrum {
//    static var data: [DailyScrum] {
//        [
//            DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, color: Color("Design")),
//            DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, color: Color("App Dev")),
//            DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 1, color: Color("Web Dev"))
//        ]
//    }
//}

//extension DailyScrum {
//    struct Data {
//        var title: String = ""
//        var attendees: [String] = []
//        var lengthInMinutes: Double = 5.0
//        var color: Color = .random
//    }
//
//    var data: Data {
//        return Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), color: color)
//    }
//
//    func update(from data: Data) {
//        title = data.title
//        for attendee in data.attendees {
//            if !attendees.contains(attendee) {
//                self.attendeeList.append(attendee)
//            }
//        }
//        lengthInMinutes = Int(data.lengthInMinutes)
//        colorComponents = data.color.components
//    }
//}

