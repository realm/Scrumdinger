//
//  DailyScrumsInteractor.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import Foundation
import RealmSwift
import SwiftUI

class DailyScrumsInteractor {
    let model: DataModel
    
    init(model: DataModel) {
        self.model = model
    }
  
    func addScrum(title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = [History]()) {
        model.pushNewScrum(title: title, attendees: attendees, lengthInMinutes: lengthInMinutes, color: color, history: history)
    }
    
//    private static func attendeeArrayToList(_ array: [String]) -> List<String> {
//        let attendees = RealmSwift.List<String>()
//        attendees.append(objectsIn: array)
//        return attendees
//    }
//    
//    private static func historyArrayToList(_ array: [History]) -> List<History> {
//        let history = RealmSwift.List<History>()
//        history.append(objectsIn: array)
//        return history
//    }
}
