//
//  PlayerView.swift
//  Sundance
//
//  Created by Imran razak on 22/06/2024.
//

import SwiftUI
import AVKit
import AVFoundation
import SwiftData
import FirebaseFirestore

struct VideoPlayerView: View {
    let run: Runs
    @State private var player: AVPlayer
    @State private var navigateToAnotherView = false
    
    @Environment(\.modelContext) private var context
    
    @State private var currentTime: Double = 0
    @State private var savedPlaybackTime: Double = 0
    @State private var isPlaying = false
    @State private var duration: Double = 0.0
    @State private var showControls = true
    
    init(run: Runs) {
        self.run = run
        let player = AVPlayer(url: URL(string: run.workoutUrl)!)
        player.allowsExternalPlayback = false // Disable AirPlay
        self._player = State(initialValue: player)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                PlayerView(player: player)
                    .edgesIgnoringSafeArea(.all)
                
                Color.black.opacity(showControls ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut, value: showControls)
                
                VStack {
                    Spacer()
                    
                    // Centered controls
                    HStack {
                        Spacer()
                        
                        Button(action: playPause) {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 60))
                        }
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                    
                    Spacer()
                    
                    // Time left and label
                    VStack(spacing: 10) {
                        Text(formattedTimeLeft)
                            .foregroundColor(.white)
                        Text("Workout Remaining")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .opacity(showControls ? 1 : 0)
                .animation(.easeInOut, value: showControls)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    showControls.toggle()
                }
            }
        }
        .onAppear {
            setupPlayer()
        }
        .preferredColorScheme(.dark)
        .overlay(
            Button(action: {
                self.savedPlaybackTime = self.currentTime
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
            .position(x: 30, y: 30)
        )
        .fullScreenCover(isPresented: $navigateToAnotherView) {
            ProfileView()
        }
    }
    
    
    private var formattedTimeLeft: String {
        let timeLeft = max(duration - currentTime, 0)
        return formattedTime(timeLeft)
    }
    
    private func formattedTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func setupPlayer() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main) { time in
            currentTime = time.seconds
            if let duration = player.currentItem?.duration.seconds {
                self.duration = duration
            }
        }
    }
    
    private func playPause() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
            hideControls()
        }
        isPlaying.toggle()
    }
    
    private func hideControls() {
        withAnimation {
            showControls = false
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
