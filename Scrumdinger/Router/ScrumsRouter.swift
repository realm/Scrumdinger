//
//  ScrumsRouter.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 16/03/2021.
//

import SwiftUI

class ScrumsRouter {
  func makeDetailView(for scrum: DailyScrum, model: DataModel) -> some View {
    let presenter = ScrumDetailPresenter(interactor:
      DailyScrumInteractor(
        scrum: scrum,
        model: model)
    )
    return DetailView(presenter: presenter)
  }
}
