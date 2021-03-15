//
//  MeetingViewModel.swift
//  Scrumdinger
//
//  Created by Lee Maguire on 15/03/2021.
//

import Foundation
import RealmSwift

class MeetingViewModel: ObservableObject {
    var scrum: DailyScrum

    init(scrum: DailyScrum) {
        self.scrum = scrum
    }

    func insertHistory(elaspsedTime: Int, transcript: String) {
        let newHistory = History(attendees: scrum.attendees,
                                 lengthInMinutes: elaspsedTime,
                                 transcript: transcript)
        do {
            try Realm().write() {
                guard let thawedScrum = scrum.thaw() else {
                    print("Unable to thaw scrum")
                    return
                }
                thawedScrum.historyList.insert(newHistory, at: 0)
            }
        } catch {
            print("Failed to add meeting to scrum: \(error.localizedDescription)")
        }
    }
}
