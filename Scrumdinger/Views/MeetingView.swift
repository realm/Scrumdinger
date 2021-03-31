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
    @ObservedRealmObject var scrum: DailyScrum
    
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
                    try Realm().write() {
                        guard let thawedScrum = scrum.thaw() else {
                            print("Unable to thaw scrum")
                            return
                        }
                        thawedScrum.historyList.insert(newHistory, at: 0)
                    }
                } catch {
                    print("Failed to add meeting to scrum: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: DailyScrum.data[0])
    }
}
