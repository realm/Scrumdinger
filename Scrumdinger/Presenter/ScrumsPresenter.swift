//
//  ScrumsPresenter.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import SwiftUI
import Combine

class ScrumsPresenter: ObservableObject {
    @Published var scrums = [DailyScrum]()
    
    private var cancellables = Set<AnyCancellable>()
    private let interactor: DailyScrumsInteractor
//    private let router = ScrumsRouter()
    
    init(interactor: DailyScrumsInteractor) {
        self.interactor = interactor
        interactor.model.$scrums
          .assign(to: \.scrums, on: self)
          .store(in: &cancellables)
    }
    
    func makeAddNewButton() -> some View {
        Button(action: addNewScrum) {
            Image(systemName: "plus")
        }
    }
    
    func addNewScrum() {
        // TODO: Open Edit view
    }
    
    func linkBuilder<Content: View>(for scrum: DailyScrum, @ViewBuilder content: () -> Content) -> some View {
        content()
//      NavigationLink(destination: router.makeDetailView(for: trip, model: interactor.model)) {
//        content()
//      }
    }
    
}
