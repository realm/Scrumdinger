/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import RealmSwift

@objcMembers class History: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var date: Date?
    var attendeeList = List<String>()
    dynamic var lengthInMinutes: Int = 0
    dynamic var transcript: String?
    var attendees: [String] { Array(attendeeList) }

    convenience init(date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.init()
        self.date = date
        attendeeList.append(objectsIn: attendees)
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
