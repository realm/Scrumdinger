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

    private let speechRecognizer = SpeechRecognizer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(viewModel.color)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: $viewModel.timer.secondsElapsed,
                    secondsRemaining: $viewModel.timer.secondsRemaining,
                    scrumColor: viewModel.color)
                MeetingTimerView(speakers: $viewModel.timer.speakers, isRecording: $viewModel.isRecording, scrumColor: viewModel.color)
                MeetingFooterView(speakers: $viewModel.timer.speakers, skipAction: viewModel.timer.skipSpeaker)
            }
            .padding()
            .foregroundColor(viewModel.color.accessibleFontColor)
            .onAppear {
                viewModel.timer.reset(lengthInMinutes: viewModel.lengthInMinutes, attendees: viewModel.attendees)
                viewModel.timer.speakerChangedAction = {
                    player.seek(to: .zero)
                    player.play()
                }
                speechRecognizer.record(to: $viewModel.transcript)
                viewModel.isRecording = true
                viewModel.timer.startScrum()
            }
            .onDisappear {
                viewModel.timer.stopScrum()
                speechRecognizer.stopRecording()
                viewModel.isRecording = false
                viewModel.insertHistory(elaspsedTime: viewModel.timer.secondsElapsed / 60,
                                        transcript: viewModel.transcript)
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(viewModel: MeetingViewModel(scrum: DailyScrum.data[0]))
    }
}
