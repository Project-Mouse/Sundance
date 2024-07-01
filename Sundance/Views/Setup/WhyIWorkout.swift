//
//  WhyIWorkout.swift
//  Sundance
//
//  Created by Imran razak on 29/06/2024.
//

import SwiftUI

struct WhyIWorkout: View {
    @State private var selectedWhy = "Lose Bum and Tum"
    let themes = ["Lose Bum and Tum", "Fit into my jeans", "Special Occasion"]
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 360, height: 60)
                            .cornerRadius(18)
                            .foregroundColor(.white)
                        
                        Picker("Why I Workout?", selection: $selectedWhy) {
                            ForEach(themes, id: \.self) {
                                Text($0)
                            }
                        }
                        .foregroundColor(.black)
                        .pickerStyle(.navigationLink)
                        .padding([.leading, .trailing], 40)
                    }
                }
                .shadow(radius: 8)
                
            }
           
        }
        .background(Color("LavenderPurple"))
    }
}
    
    #Preview {
        WhyIWorkout()
    }
