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
            //let padding: CGFloat = 16
            let availableWidth = geometry.size.width
            let height: CGFloat = 480
            
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
                //.clipShape(RoundedRectangle(cornerRadius: 18))
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.50), Color.clear]),
                               startPoint: .top,
                               endPoint: .bottom)
                .frame(width: availableWidth, height: height)
               // .cornerRadius(18)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .center) {
                            Text("Upper Body Strength")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                               // .padding(.bottom, 10)
                            
                            if isCompleted {
                                Button {
                                    //Action
                                    showHuddle.toggle()
                                }label: {
                                    Text("Completed ✅")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(maxWidth: 280, maxHeight: 60)
                                .background(.green)
                                .cornerRadius(18)
                                .shadow(radius: 10)
                                //.padding()
                            } else {
                                Button {
                                    //Action
                                    showHuddle.toggle()
                                }label: {
                                    Text("Let's Go!")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(maxWidth: 280, maxHeight: 60)
                                .background(.blue)
                                .cornerRadius(18)
                                .shadow(radius: 10)
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: availableWidth, height: height)
            }
            .frame(width: availableWidth, height: height)
            .padding(.bottom)
        }
        .frame(height: 480)
        .fullScreenCover(isPresented: $showHuddle) {
            PreWorkoutView(run: Runs(runIdent: run.runIdent,
                                      thumbnail: run.thumbnail,
                                      runType: run.runType,
                                      coachUrl: run.coachUrl,
                                      releaseDate: run.releaseDate,
                                      workoutUrl: run.workoutUrl,
                                      trainer: run.trainer))
        }
    }
}
