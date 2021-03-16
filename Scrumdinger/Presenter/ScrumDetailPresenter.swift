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
    
    init(interactor: DailyScrumInteractor) {
        self.interactor = interactor
        
        setTitle = Binding<String>(
            get: { interactor.scrum.title },
            set: { interactor.setTitle($0) }
        )
    }
}
