import RealmSwift
import XCTest
@testable import Scrumdinger

/// This class demonstrates the test coverage of ViewModels at a very basic level. They are not comprehensive
/// and do not cover all edge cases.
class ScrumdingerTests: XCTestCase {

    var realm: Realm!

    override func setUpWithError() throws {
        realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

    func testScrumsViewModel() {
        let viewModel = ScrumsViewModel()
        XCTAssertEqual(viewModel.scrumViewModels.count, 0)
        try! realm.write {
            realm.add(DailyScrum.data)
        }
        XCTAssertEqual(viewModel.scrumViewModels.count, 3)
    }

    func testCreateScrum() {
        let viewModel = ScrumsViewModel(realmConfiguration: realm.configuration)
        viewModel.createScrum(title: "Test",
                              attendees: ["John", "Mary"],
                              lengthInMinutes: 5,
                              color: .pink)
        XCTAssertEqual(viewModel.scrumViewModels.count, 1)

        XCTAssertEqual(viewModel.scrumViewModels[0].title, "Test")
        XCTAssertEqual(viewModel.scrumViewModels[0].attendees, ["John", "Mary"])
        XCTAssertEqual(viewModel.scrumViewModels[0].lengthInMinutes, 5.0)
        XCTAssertEqual(viewModel.scrumViewModels[0].lengthInMinutesText, "5 minutes")
    }

    func testMeetingViewModel() {
        let scrum = DailyScrum.data[0]
        try! realm.write {
            realm.add(scrum)
        }
        let viewModel = MeetingViewModel(scrum: scrum,
                                         realmConfiguration: realm.configuration)
        XCTAssertEqual(viewModel.attendees, ["Cathy", "Daisy", "Simon", "Jonathan"])
        XCTAssertEqual(viewModel.lengthInMinutes, 10)
        XCTAssertEqual(viewModel.title, "Design")

        XCTAssertEqual(viewModel.history.count, 0)

        viewModel.insertHistory(elaspsedTime: 5, transcript: "Blah Blah")

        XCTAssertEqual(viewModel.history.count, 1)
        XCTAssertEqual(viewModel.history[0].transcript, "Blah Blah")
        XCTAssertEqual(viewModel.history[0].lengthInMinutes, 5)
    }

    func testUpdateFromEditViewModel() {
        let scrum = DailyScrum.data[0]
        try! realm.write {
            realm.add(scrum)
        }
        let viewModel = EditViewModel(scrum: scrum,
                                      realmConfiguration: realm.configuration)

        XCTAssertEqual(viewModel.attendees, ["Cathy", "Daisy", "Simon", "Jonathan"])
        viewModel.removeAttendee(at: [0])
        XCTAssertEqual(viewModel.attendees, ["Daisy", "Simon", "Jonathan"])
        viewModel.newAttendee = "Lee"
        viewModel.addAttendee()
        XCTAssertEqual(viewModel.attendees, ["Daisy", "Simon", "Jonathan", "Lee"])
        viewModel.addAttendee() // Cannot add an empty named attendee
        XCTAssertEqual(viewModel.attendees, ["Daisy", "Simon", "Jonathan", "Lee"])
        viewModel.update()
        XCTAssertEqual(EditViewModel(scrum: realm.objects(DailyScrum.self).first!).attendees,
                       ["Daisy", "Simon", "Jonathan", "Lee"])
    }

    func testCreateFromEditViewModel() {
        let viewModel = EditViewModel(realmConfiguration: realm.configuration)
        XCTAssertEqual(viewModel.attendees, [])
        viewModel.removeAttendee(at: [0])
        XCTAssertEqual(viewModel.attendees, [])
        viewModel.newAttendee = "Lee"
        viewModel.addAttendee()
        XCTAssertEqual(viewModel.attendees, ["Lee"])
        viewModel.addAttendee() // Cannot add an empty named attendee
        XCTAssertEqual(viewModel.attendees, ["Lee"])
        viewModel.createScrum() // We did not pass validation
        XCTAssertEqual(realm.objects(DailyScrum.self).count, 0)
        viewModel.title = "Test"
        viewModel.lengthInMinutes = 5
        viewModel.createScrum()
        XCTAssertEqual(realm.objects(DailyScrum.self).count, 1)
    }

}
