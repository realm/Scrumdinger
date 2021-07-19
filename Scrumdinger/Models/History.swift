/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import RealmSwift

class History: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var date: Date?
    @Persisted var attendeeList = List<String>()
    @Persisted var lengthInMinutes: Int = 0
    @Persisted var transcript: String?
    var attendees: [String] { Array(attendeeList) }

    convenience init(date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.init()
        self.date = date
        attendeeList.append(objectsIn: attendees)
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
