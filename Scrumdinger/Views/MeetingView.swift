//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Andrew Morgan on 22/12/2020.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    @EnvironmentObject var state: AppState
    
    @StateObject var scrumTimer = ScrumTimer()
    @State private var transcript = ""
    @State private var isRecording = false
    private let speechRecognizer = SpeechRecognizer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: $scrumTimer.secondsElapsed,
                    secondsRemaining: $scrumTimer.secondsRemaining,
                    scrumColor: scrum.color)
                MeetingTimerView(speakers: $scrumTimer.speakers, isRecording: $isRecording, scrumColor: scrum.color)
                MeetingFooterView(speakers: $scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
            .foregroundColor(scrum.color.accessibleFontColor)
            .onAppear {
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
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
                let newHistory = History(attendees: scrum.attendees,
                                         lengthInMinutes: scrumTimer.secondsElapsed / 60,
                                         transcript: transcript)
                do {
                    try state.realm.write {
                        scrum.historyList.insert(newHistory, at: 0)
                    }
                } catch {
                    print("Failed to add history element to Realm")
                }
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
            .environmentObject(AppState.sample)
    }
}
