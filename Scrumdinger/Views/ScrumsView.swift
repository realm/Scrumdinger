//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

struct ScrumsView: View {
    @StateObject private var viewModel = ScrumsViewModel()
    
    var body: some View {
        List {
            if let scrums = viewModel.scrums {
                ForEach(scrums) { scrum in
                    NavigationLink(destination: DetailView(scrum: scrum)) {
                        CardView(scrum: scrum)
                    }
                    .listRowBackground(scrum.color)
                }
            }
        }
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {
            viewModel.isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $viewModel.isPresented) {
            NavigationView {
                EditView(scrumData: $viewModel.newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        viewModel.isPresented = false
                    }, trailing: Button("Add") {
                        viewModel.addScrum(from: viewModel.newScrumData)
                        viewModel.isPresented = false
                    })
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView()
        }
    }
}
