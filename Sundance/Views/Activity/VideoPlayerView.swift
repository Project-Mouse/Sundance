//
//  PlayerView.swift
//  Sundance
//
//  Created by Imran razak on 22/06/2024.
//

import SwiftUI
import AVKit
import SwiftData
import FirebaseFirestore

struct VideoPlayerView: View {
    //var videoURL: String
    let run: Runs
    @State private var player: AVPlayer
    @State private var navigateToAnotherView = false
    @Environment(\.modelContext) private var context
    @State private var currentTime: Double = 0
    @State private var savedPlaybackTime: Double = 0
    
    
    init(run: Runs) {
        self.run = run
        let player = AVPlayer(url: URL(string: run.workoutUrl)!)
        player.allowsExternalPlayback = false // Disable AirPlay
        self._player = State(initialValue: player)
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    self.player.play()
                    // Add a periodic time observer
                    let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
                    player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
                        self.currentTime = time.seconds
                    }
                }
            Spacer()
        }
        .preferredColorScheme(.dark)
        .overlay(
            Button(action: {
                self.savedPlaybackTime = self.currentTime // Current playback time
                saveWorkoutLocally()
                saveWorkoutCloud()
                self.navigateToAnotherView = true
            }) {
                Image(systemName: "xmark")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
            .padding()
            .position(x: 30, y: 30) // Adjusted position here
        )
        .fullScreenCover(isPresented: $navigateToAnotherView) {
            ProfileView() // Change to your desired view
        }
    }
    
    private func saveWorkoutLocally() {
        let workout = WorkoutModel(workoutId: run.runIdent,
                                   workoutDuration: Int(self.savedPlaybackTime),
                                   workoutType: run.runType,
                                   workoutTrainer: run.trainer,
                                   workoutDate: Date())
        
        context.insert(workout)
    }
    
    private func saveWorkoutCloud() {
        let db = Firestore.firestore()
        
        let workoutData: [String: Any] = [
            "workoutId": run.runIdent,
            "workoutDuration": Int(self.savedPlaybackTime),
            "workoutType": run.runType,
            "workoutTrainer": run.trainer,
            "workoutDate": Date()
        ]
        
        //TODO: Error Handling
        db.collection("Workouts").addDocument(data: workoutData) { error in
            if let error = error {
                print("Error saving profile to Cloud: \(error.localizedDescription)")
            } else {
                print("Profile successfully saved to Cloud.")
            }
        }
    }
}
