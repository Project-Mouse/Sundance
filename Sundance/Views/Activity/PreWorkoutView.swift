//
//  PreWorkoutView.swift
//  Sundance
//
//  Created by Imran razak on 28/06/2024.
//

import SwiftUI

struct PreWorkoutView: View {
    let run: Runs
    var body: some View {
        NavigationStack{
            ZStack {
                // Asynchronously load the image from the URL
                AsyncImage(url: URL(string: run.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray // Placeholder
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    case .failure:
                        Color.red // Error placeholder
                //TODO: ERROR VIEW
                    @unknown default:
                        Color.blue // Fallback
                    }
                }
                
                VStack{
                    Spacer()
                    ZStack{
                        Rectangle()
                            .frame(width: 360, height: 200)
                            .foregroundColor(Color.black.opacity(0.60))
                            .cornerRadius(30)
                            .shadow(radius: 8)
                        
                        VStack{
                            Text(run.runType)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 2)
                            Text(run.trainer)
                                .foregroundColor(.white)
                                .font(.title3)
                            
                            
                            Button {
                                //Action
                                
                            }label: {
                                Text("Start")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(maxWidth: 320, maxHeight: 60)
                            .background(.blue)
                            .cornerRadius(18)
                            .shadow(radius: 10)
                            .padding(.top)
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                           Image(systemName: "chevron.left.circle.fill")
                               .font(.system(size: 25))
                               .foregroundColor(.black)
                               .shadow(radius: 5)
                       }
                   }
        }
       
    }
}

#Preview {
    PreWorkoutView(run: Runs(runIdent: 1,
                             thumbnail: "https://www.apple.com/newsroom/images/2024/06/apple-vision-pro-arrives-in-new-countries-and-regions-beginning-june-28/article/Apple-WWDC24-Vision-Pro-global-availability-hero-240610_big.jpg.large_2x.jpg",
                             runType: "Upper Body Strength",
                             coachUrl: "",
                             releaseDate: "",
                             workoutUrl: "",
                             trainer: "Imran Razak"))
}
