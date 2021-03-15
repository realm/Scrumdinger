//
//  CardView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI

struct CardView: View {

    let viewModel: DailyScrumViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(viewModel.attendees.count)", systemImage: "person.3")
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Attendees"))
                    .accessibilityValue(Text("\(viewModel.attendees.count)"))
                Spacer()
                Label(viewModel.lengthInMinutesText, systemImage: "clock")
                    .padding(.trailing, 20)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Meeting length"))
                    .accessibilityValue(Text(viewModel.lengthInMinutesText))
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(viewModel.color.accessibleFontColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.data[0]
    static var previews: some View {
        CardView(viewModel: DailyScrumViewModel(scrum: DailyScrum.data.first!))
            .background(scrum.color)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
