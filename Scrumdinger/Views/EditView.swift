import SwiftUI

struct EditView: View {
    @ObservedObject var viewModel: EditViewModel
    @Binding var isPresented: Bool
    var context: Context

    enum Context {
        case scrumsView
        case detailView
    }


    func navigationView<Content: View>(context: Context, @ViewBuilder view: () -> Content) -> some View {
        if context == .scrumsView {
            return view()
            .navigationBarItems(leading: Button("Dismiss") {
                isPresented = false
            }, trailing: Button("Add") {
                viewModel.createScrum()
                isPresented = false
            })
        } else if context == .detailView {
            return view()
                .navigationBarItems(leading: Button("Cancel") {
                    isPresented = false
                }, trailing: Button("Done") {
                    isPresented = false
                    viewModel.update()
                })
        } else {
            fatalError()
        }
    }

    var body: some View {
        navigationView(context: context) {
            List {
                Section(header: Text("Meeting Info")) {
                    TextField("Title", text: $viewModel.title)
                    HStack {
                        Slider(value: $viewModel.lengthInMinutes, in: 5...30, step: 1.0) {
                            Text("Length")
                        }
                        .accessibilityValue(Text(viewModel.lengthInMinutesText))
                        Spacer()
                        Text(viewModel.lengthInMinutesText)
                            .accessibilityHidden(true)
                    }
                    ColorPicker("Color", selection: $viewModel.color)
                        .accessibilityLabel(Text("Color picker"))
                }
                Section(header: Text("Attendees")) {
                    ForEach(viewModel.attendees, id: \.self) { attendee in
                        Text(attendee)
                    }
                    .onDelete { indices in
                        viewModel.removeAttendee(at: indices)
                    }
                    HStack {
                        TextField("New Attendee", text: $viewModel.newAttendee)
                        Button(action: {
                            withAnimation {
                                viewModel.addAttendee()
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .accessibilityLabel(Text("Add attendee"))
                        }
                        .disabled(viewModel.newAttendee.isEmpty)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(viewModel: EditViewModel(), isPresented: .constant(true), context: .scrumsView)
    }
}
