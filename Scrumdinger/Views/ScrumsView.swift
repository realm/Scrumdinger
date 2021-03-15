import SwiftUI
import RealmSwift

struct ScrumsView: View {
    @ObservedObject private var viewModel: ScrumsViewModel

    init(viewModel: ScrumsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            if let viewModels = viewModel.scrumViewModels {
                ForEach(viewModels) { detailViewModel in
                    NavigationLink(destination: DetailView(viewModel: detailViewModel)) {
                        CardView(viewModel: detailViewModel)
                    }
                    .listRowBackground(detailViewModel.color)
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
                EditView(viewModel: EditViewModel(),
                         isPresented: $viewModel.isPresented,
                         context: .scrumsView)
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(viewModel: ScrumsViewModel())
        }
    }
}
