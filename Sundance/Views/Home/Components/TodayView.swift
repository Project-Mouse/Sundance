//
//  TodayView.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import SwiftUI

struct TodayView: View {
    let run: Runs
    let isCompleted: Bool
    @State private var showHuddle: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let padding: CGFloat = 16
            let availableWidth = geometry.size.width - (2 * padding)
            let height: CGFloat = 480 - (2 * padding)
            
            ZStack {
                AsyncImage(url: URL(string: run.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle().foregroundColor(.gray)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Rectangle().foregroundColor(.gray)
                    @unknown default:
                        Rectangle().foregroundColor(.gray)
                    }
                }
                .frame(width: availableWidth, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.40), Color.clear]),
                               startPoint: .bottom,
                               endPoint: .top)
                .frame(width: availableWidth, height: height)
                .cornerRadius(18)
                
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("For You")
                                .foregroundColor(.white)
                            Text("Today's Workout")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: availableWidth, height: height)
                
                // Add this VStack for the green check circle
                VStack {
                    HStack {
                        Spacer()
                        if isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 30))
                                .padding()
                        }
                    }
                    Spacer()
                }
                .frame(width: availableWidth, height: height)
            }
            .frame(width: availableWidth, height: height)
            .shadow(radius: 10)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 480)
        .onTapGesture {
            showHuddle.toggle()
        }
        .fullScreenCover(isPresented: $showHuddle) {
            VideoPlayerView(run: Runs(runIdent: run.runIdent,
                                      thumbnail: run.thumbnail,
                                      runType: run.runType,
                                      coachUrl: run.coachUrl,
                                      releaseDate: run.releaseDate,
                                      workoutUrl: run.workoutUrl,
                                      trainer: run.trainer))
        }
    }
}
