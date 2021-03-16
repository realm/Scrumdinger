//
//  DailyScrumInteractor.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import Combine
import SwiftUI

class DailyScrumInteractor {
    private let model: DataModel
    let scrum: DailyScrum
    
//    private var cancellables = Set<AnyCancellable>()
    
    var title: String { scrum.title }
    var titlePublisher: Published<String>.Publisher { scrum.$title }
    var color: Color { scrum.color }
    var colorPublisher: Published<Components?>.Publisher { scrum.$colorComponents }
    
    init(scrum: DailyScrum, model: DataModel) {
        self.scrum = scrum
        self.model = model
    }
    
    func setTitle(_ title: String) {
        scrum.updateTitle(title)
    }
    
    func setLengthInMinutes(_ duration: Int) {
        scrum.updateDuration(duration)
    }
    
    func setColor(_ color: Color) {
        scrum.updateColor(color)
    }
    
    func addToHistory(_ history: History) {
        scrum.addToHistory(history)
    }
}
