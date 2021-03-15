import Combine
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

    var isRecording = false {
        didSet {
            objectWillChange.send()
        }
    }

    var transcript = "" {
        didSet {
            objectWillChange.send()
        }
    }

    var timer: ScrumTimer = ScrumTimer()

    private var scrum: DailyScrum
    private var token: AnyCancellable?

    init (scrum: DailyScrum) {
        self.scrum = scrum

        token = timer.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }

    deinit {
        token = nil
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
