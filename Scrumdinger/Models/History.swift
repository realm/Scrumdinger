/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import RealmSwift

class History: EmbeddedObject, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date: Date?
    let attendeeList = List<String>()
    @objc dynamic var lengthInMinutes: Int = 0
    @objc dynamic var transcript: String?
    var attendees: [String] { Array(attendeeList) }

    convenience init(date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.init()
        self.date = date
        for attendee in attendees {
            self.attendeeList.append(attendee)
        }
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
