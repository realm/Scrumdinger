import SwiftUI
import RealmSwift

struct DetailView: View {
    @ObservedObject private var viewModel: DailyScrumViewModel

    init(viewModel: DailyScrumViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(
                    destination: MeetingView(viewModel: MeetingViewModel(scrum: viewModel.scrum))
                ) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(viewModel.lengthInMinutesText)
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(viewModel.color)
                }
                .accessibilityElement(children: .ignore)
            }
            Section(header: Text("Attendees")) {
                ForEach(viewModel.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("Person"))
                        .accessibilityValue(Text(attendee))
                }
            }
            Section(header: Text("History")) {
                if viewModel.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(viewModel.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            if let date = history.date {
                                Text(date, style: .date)
                            } else {
                                Text("Date is missing")
                            }
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            viewModel.isPresented = true
        })
        .navigationTitle(viewModel.title)
        .fullScreenCover(isPresented: $viewModel.isPresented) {
            NavigationView {
                EditView(viewModel: EditViewModel(scrum: viewModel.scrum),
                         isPresented: $viewModel.isPresented,
                         context: .detailView)
                    .navigationTitle(viewModel.title)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(viewModel: DailyScrumViewModel(scrum: DailyScrum.data.first!))
        }
    }
}
