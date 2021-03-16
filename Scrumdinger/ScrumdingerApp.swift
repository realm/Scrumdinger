//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

@main
struct ScrumdingerApp: SwiftUI.App {
//    let model = DataModel()
    let model = DataModel.sample
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(presenter: ScrumsPresenter(interactor: DailyScrumsInteractor(model: model)))
            }
        }
    }
}
