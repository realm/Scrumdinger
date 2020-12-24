//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift

struct ScrumsView: View {
//    @Binding var scrums: [DailyScrum]
    
//    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var state: AppState
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    @State private var scrums: Results<DailyScrum>?
//    @State private var currentScrum = DailyScrum.data[0]
    @State private var currentScrum = DailyScrum()
    
//    let saveAction: () -> Void
    
    var body: some View {
        List {
            if let scrums = scrums {
                ForEach(scrums) { scrum in
//                    NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    NavigationLink(destination: DetailView(scrum: $currentScrum)) {
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
                // TODO: Interesting that the nav buttons are added here, rather than in EditView
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
                            try state.realm.write {
                                state.realm.add(newScrum)
                            }
                        } catch {
                            print("Failed to write to realm")
                        }
//                        scrums.append(newScrum)
                        isPresented = false
                    })
            }
        }
        .onAppear {
            scrums = state.realm.objects(DailyScrum.self)
        }
        
//        .onChange(of: scenePhase) { phase in
//            if phase == .inactive { saveAction() }
//        }
    }
    
    // TODO: See if this simplifies any of my apps
//    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
//        guard let scrums = scrums, let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
//            fatalError("Can't find scrum in array")
//        }
//        return $scrums[scrumIndex]
//    }
}

struct ScrumsView_Previews: PreviewProvider {
//    static let state = AppState()
    
    static var previews: some View {
        NavigationView {
            ScrumsView()
                .environmentObject(AppState())
        }
    }
}
