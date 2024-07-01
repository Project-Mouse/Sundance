//
//  HomeView.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//



/*
 Absract
 
 */

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var workouts: [WorkoutModel]
    @State private var todaysRun: Runs?
    @State private var dataLoaded = false
    
    let apiService: APIService = APIService()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack{
                    if let run = todaysRun {
                        TodayView(run: run, isCompleted: isWorkoutCompleted(run))
                            .padding(.bottom)
                    }
                        
                    
                    Spacer()
                    
                    InsightsView(title: "Insights")
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationTitle("Today")
            .onAppear {
                if !dataLoaded {
                    loadAPI()
                    dataLoaded = true
                }
            }
            .scrollIndicators(.never)
            .toolbar {
                ToolbarItem {
                    Rectangle()
                        .frame(width: 35, height: 35)
                        .cornerRadius(8)
                        .foregroundColor(.yellow)
                }
            }
        }
    }
    
    private func loadAPI() {
        Task {
            do {
                let runs = try await apiService.listRuns()
                if let firstRun = runs.first {
                    self.todaysRun = firstRun
                }
            } catch {
                print("error loading runs \(error)")
            }
        }
    }
    
    private func isWorkoutCompleted(_ run: Runs) -> Bool {
        return workouts.contains { $0.workoutId == run.runIdent }
    }
}

#Preview {
    HomeView()
}
