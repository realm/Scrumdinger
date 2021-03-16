//
//  ScrumDetailPresenter.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import SwiftUI
import Combine

class ScrumDetailPresenter: ObservableObject {
    private let interactor: DailyScrumInteractor
//    private let router: ScrumDetailRouter

    private var cancellables = Set<AnyCancellable>()
    
    @Published var title: String  = "No title"
    let setTitle: Binding<String>
    @Published var lengthInMinutes = 10
    let setLengthInMinutes: Binding<Int>
    @Published var color = Color.random
    let setColor: Binding<Color>
    @Published var history = [History]()
//    let addToHistory: Binding<History>
    
    init(interactor: DailyScrumInteractor) {
        self.interactor = interactor
        
        setTitle = Binding<String>(
            get: { interactor.scrum.title },
            set: { interactor.setTitle($0) }
        )
        
        setLengthInMinutes = Binding<Int>(
            get: { interactor.scrum.lengthInMinutes },
            set: { interactor.setLengthInMinutes($0) }
        )
        
        setColor = Binding<Color>(
            get: { interactor.scrum.color },
            set: { interactor.setColor($0) }
        )
        
//        addToHistory = Binding<History>(
//            get: { interactor.scrum.history.last ?? History() },
//            set: { interactor.addToHistory($0) }
//        )
    }
}
