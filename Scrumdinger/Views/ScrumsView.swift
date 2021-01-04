//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

struct ScrumsView: View {
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    @State private var scrums: Results<DailyScrum>?
    @State private var currentScrum = DailyScrum()
    
    var body: some View {
        List {
            if let scrums = scrums {
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
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newScrum = DailyScrum(
                            title: newScrumData.title,
                            attendees: newScrumData.attendees,
                            lengthInMinutes: Int(newScrumData.lengthInMinutes),
                            color: newScrumData.color)
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.add(newScrum)
                            }
                        } catch {
                            print("Failed to write to realm")
                        }
                        isPresented = false
                    })
            }
        }
        .onAppear {
            let realm = try! Realm()
            scrums = realm.objects(DailyScrum.self)
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
