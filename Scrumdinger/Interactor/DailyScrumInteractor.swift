//
//  DailyScrumInteractor.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import Combine

class DailyScrumInteractor {
    private let model: DataModel
    let scrum: DailyScrum
    
    private var cancellables = Set<AnyCancellable>()
    
    init(scrum: DailyScrum, model: DataModel) {
        self.scrum = scrum
        self.model = model
    }
    
    func setTitle(_ title: String) {
        scrum.updateTitle(title)
    }
}
