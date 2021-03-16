import RealmSwift
import SwiftUI

class ScrumsViewModel: ObservableObject {

    private var realmConfiguration: Realm.Configuration

    // MARK: - Model
    private var scrums: Results<DailyScrum>
    private var notificationToken: NotificationToken?

    // MARK: - Presentation
    var isPresented = false {
        didSet {
            objectWillChange.send()
        }
    }

    var scrumViewModels: [DailyScrumViewModel] {
        scrums.map { DailyScrumViewModel(scrum: $0) }
    }

    init(realmConfiguration: Realm.Configuration = .defaultConfiguration) {
        self.realmConfiguration = realmConfiguration
        do {
            let realm = try Realm(configuration: realmConfiguration)
            scrums = realm.objects(DailyScrum.self)
            notificationToken = realm.objects(DailyScrum.self).observe { changes in
                self.objectWillChange.send()
            }
        } catch(let e) {
            fatalError(e.localizedDescription)
        }
    }

    deinit {
        notificationToken = nil
    }

    /// Add a Daily Scrum event and persist to Realm.
    func createScrum(title: String,
                     attendees: [String],
                     lengthInMinutes: Int,
                     color: Color) {
        let newScrum = DailyScrum(
            title: title,
            attendees: attendees,
            lengthInMinutes: lengthInMinutes,
            color: color)
        do {
            let realm = try Realm(configuration: realmConfiguration)
            try realm.write {
                realm.add(newScrum)
            }
        } catch(let e) {
            print(e.localizedDescription)
        }
    }
}
