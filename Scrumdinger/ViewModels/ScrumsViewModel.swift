import Foundation
import RealmSwift

class ScrumsViewModel: ObservableObject {

    // MARK: - Model
    var scrums: Results<DailyScrum>?
    var newScrumData = DailyScrum.Data()
    var currentScrum = DailyScrum()
    var notificationToken: NotificationToken?

    // MARK: - Presentation
    var isPresented = false {
        didSet {
            objectWillChange.send()
        }
    }

    init() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(DailyScrum.self).observe { change in
                switch change {
                    case .initial(let initial):
                        self.scrums = initial
                        break
                    case .update(let results, deletions: _, insertions: _, modifications: _):
                        self.scrums = results
                        break
                    case .error(let e):
                        print(e.localizedDescription)
                }
                self.objectWillChange.send()
            }
        } catch(let e) {
            print(e)
        }
    }

    deinit {
        notificationToken = nil
    }

    /// Add a Daily Scrum event and persist to Realm.
    /// - Parameter data: The Daily Scrum data
    func addScrum(from data: DailyScrum.Data) {
        let newScrum = DailyScrum(
            title: data.title,
            attendees: data.attendees,
            lengthInMinutes: Int(data.lengthInMinutes),
            color: data.color)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newScrum)
            }
        } catch(let e) {
            print(e.localizedDescription)
        }
    }
}
