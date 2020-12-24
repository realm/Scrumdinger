/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import RealmSwift

class History: EmbeddedObject, Identifiable {
    @objc dynamic var id: UUID
    @objc dynamic var date: Date
    let attendees = List<String>()
    @objc dynamic var lengthInMinutes: Int
    @objc dynamic var transcript: String?

    init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.id = id
        self.date = date
        for attendee in attendees {
            self.attendees.append(attendee)
        }
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
