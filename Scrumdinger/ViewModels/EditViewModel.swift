import RealmSwift
import SwiftUI

class EditViewModel: ObservableObject {

    // MARK: - Properties

    var title: String = "" {
        didSet {
            objectWillChange.send()
        }
    }

    var attendees: [String] {
        didSet {
            objectWillChange.send()
        }
    }

    var lengthInMinutes: Double = 5.0 {
        didSet {
            objectWillChange.send()
        }
    }

    var color: Color {
        didSet {
            objectWillChange.send()
        }
    }

    var history: [History] {
        scrum.history.map { $0 }
    }

    var lengthInMinutesText: String {
        "\(Int(lengthInMinutes)) minutes"
    }

    var newAttendee = "" {
        didSet {
            objectWillChange.send()
        }
    }

    private var scrum: DailyScrum

    // MARK: - Add / Remove Attendee

    func addAttendee() {
        if newAttendee.isEmpty {
            return
        }
        attendees.append(newAttendee)
        newAttendee = ""
        objectWillChange.send()
    }

    func removeAttendee(at indices: IndexSet) {
        attendees.remove(atOffsets: indices)
        objectWillChange.send()
    }

    // MARK: - Create, Update DailyScrum

    /// Persists the DailyScrum object to Realm.
    func createScrum() {
        if !validate() {
            return
        }
        do {
            let r = try Realm()
            try r.write {
                r.add(scrum)
            }
        } catch(let e) {
            print(e.localizedDescription)
        }
    }

    func update() {
        if !validate() {
            return
        }
        do {
            let r = try Realm()
            try r.write {
                scrum.title = title
                scrum.lengthInMinutes = Int(lengthInMinutes)
                scrum.colorComponents = color.components
                scrum.attendees.removeAll()
                scrum.attendees.append(objectsIn: attendees)
            }
        } catch(let e) {
            print(e.localizedDescription)
        }
    }

    private func validate() -> Bool {
        // validate we can persist
        if attendees.isEmpty || title.isEmpty {
            // TODO: throw some fancy red colors on the UI
            return false
        }
        return true
    }

    // MARK: - Initializers

    init(scrum: DailyScrum?=nil) {
        if let s = scrum {
            self.scrum = s
        } else {
            self.scrum = DailyScrum()
        }
        title = self.scrum.title
        lengthInMinutes = Double(self.scrum.lengthInMinutes)
        color = self.scrum.color
        attendees = self.scrum.attendees.map { $0 }
    }
}
