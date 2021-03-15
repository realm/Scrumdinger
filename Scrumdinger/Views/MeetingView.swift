//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import RealmSwift
import AVFoundation

struct MeetingView: View {
    @ObservedObject var viewModel: MeetingViewModel

    @StateObject var scrumTimer = ScrumTimer()
    @State private var transcript = ""
    @State private var isRecording = false
    private let speechRecognizer = SpeechRecognizer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(viewModel.scrum.color)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: $scrumTimer.secondsElapsed,
                    secondsRemaining: $scrumTimer.secondsRemaining,
                    scrumColor: viewModel.scrum.color)
                MeetingTimerView(speakers: $scrumTimer.speakers, isRecording: $isRecording, scrumColor: viewModel.scrum.color)
                MeetingFooterView(speakers: $scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
            .foregroundColor(viewModel.scrum.color.accessibleFontColor)
            .onAppear {
                scrumTimer.reset(lengthInMinutes: viewModel.lengthInMinutes, attendees: viewModel.attendees)
                scrumTimer.speakerChangedAction = {
                    player.seek(to: .zero)
                    player.play()
                }
                speechRecognizer.record(to: $transcript)
                isRecording = true
                scrumTimer.startScrum()
            }
            .onDisappear {
                scrumTimer.stopScrum()
                speechRecognizer.stopRecording()
                isRecording = false
                viewModel.insertHistory(elaspsedTime: scrumTimer.secondsElapsed / 60,
                                        transcript: transcript)
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(viewModel: MeetingViewModel(scrum: DailyScrum.data[0]))
    }
}
