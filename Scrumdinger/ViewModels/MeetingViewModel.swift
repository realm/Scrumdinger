import Foundation
import RealmSwift
import SwiftUI

class MeetingViewModel: ObservableObject {
    var title: String {
        scrum.title
    }
    var attendees: [String] {
        scrum.attendees.map { $0 }
    }
    var lengthInMinutes: Int {
        scrum.lengthInMinutes
    }
    var color: Color {
        scrum.color
    }
    var history: [History] {
        scrum.history.map { $0 }
    }
    private(set) var scrum: DailyScrum

    init (scrum: DailyScrum) {
        self.scrum = scrum
    }

    func insertHistory(elaspsedTime: Int, transcript: String) {
        let newHistory = History(attendees: attendees,
                                 lengthInMinutes: elaspsedTime,
                                 transcript: transcript)
        do {
            try Realm().write() {
                guard let thawedScrum = scrum.thaw() else {
                    print("Unable to thaw scrum")
                    return
                }
                thawedScrum.history.insert(newHistory, at: 0)
            }
        } catch {
            print("Failed to add meeting to scrum: \(error.localizedDescription)")
        }
    }
}
