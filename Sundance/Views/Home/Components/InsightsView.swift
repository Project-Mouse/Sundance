//
//  InsightsView.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI
import SwiftData

struct InsightsView: View {
    let title: String
    @Query private var workouts: [WorkoutModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            if workouts.isEmpty {
                ZStack {
                    Rectangle()
                        .frame(height: 160)
                        .foregroundColor(.yellow)
                        .cornerRadius(18)
                    
                    Text("Oh no!🙈 It look's like we don't have enough workout data to show you any insights.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        InsightTile(title: "Workouts\nCompleted", value: "\(workouts.count)")
                        InsightTile(title: "Total\nDuration", value: formatDuration(totalDuration))
                        InsightTile(title: "Most Popular\nWorkout", value: mostPopularWorkout)
                        InsightTile(title: "Average\nDuration", value: formatDuration(averageDuration))
                    }
                }
                .padding([.leading, .bottom])
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var totalDuration: Int {
        workouts.reduce(0) { $0 + $1.workoutDuration }
    }
    
    private var averageDuration: Int {
        workouts.isEmpty ? 0 : totalDuration / workouts.count
    }
    
    private var mostPopularWorkout: String {
        let typeCount = workouts.reduce(into: [:]) { counts, workout in
            counts[workout.workoutType, default: 0] += 1
        }
        return typeCount.max(by: { $0.value < $1.value })?.key ?? "N/A"
    }
    
    private func formatDuration(_ duration: Int) -> String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
}

struct InsightTile: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 160, height: 160)
                .foregroundColor(Color(.systemGray5))
                .cornerRadius(18)
            
            VStack(alignment: .center) {
                Text(value)
                    .font(.title)
                    .bold()
                Text(title)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    InsightsView(title: "Insights")
}
