//
//  StoryView.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI

struct NewWeekView: View {
    
    let run: Runs
    
    
    @State private var showHuddle: Bool = false
    
    var body: some View {
        
        ZStack {
            // AsyncImage instead of Rectangle
            AsyncImage(url: URL(string: run.thumbnail)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(18)
                        .frame(width: 125, height: 160)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                case .failure:
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(18)
                        .frame(width: 125, height: 160)
                @unknown default:
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(18)
                        .frame(width: 125, height: 160)
                }
            }
            
        }
        .onTapGesture {
            showHuddle.toggle()
        }
        .fullScreenCover(isPresented: $showHuddle){
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

