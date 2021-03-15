import RealmSwift
import SwiftUI

class DailyScrumViewModel: ObservableObject, Identifiable {
    var title: String {
        get {
            scrum.title
        }
        set {
            scrum.title = newValue
        }
    }
    var attendees: [String] {
        scrum.attendees.map { $0 }
    }
    var lengthInMinutes: Double {
        get {
            Double(scrum.lengthInMinutes)
        }
        set {
            scrum.lengthInMinutes = Int(newValue)
        }
    }
    var color: Color {
        get {
            scrum.color
        }
    }
    var history: [History] {
        scrum.history.map { $0 }
    }

    var lengthInMinutesText: String {
        "\(scrum.lengthInMinutes) minutes"
    }

    var isPresented = false {
        didSet {
            objectWillChange.send()
        }
    }

    private(set) var scrum: DailyScrum
    private var notificationToken: NotificationToken?

    init (scrum: DailyScrum) {
        self.scrum = scrum
        notificationToken = scrum.observe { changes in
            self.objectWillChange.send()
        }
    }

    deinit {
        notificationToken = nil
    }
}
