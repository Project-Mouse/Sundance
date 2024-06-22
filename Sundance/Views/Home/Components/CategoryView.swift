//
//  CategoryView.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI

struct CategoryView: View {
    
    @State var workoutCat: [WorkoutCategories] = []
    
    let apiService: APIService = APIService()
    var body: some View {
        
        VStack(alignment: .leading){
                Text("Explore Workouts")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(workoutCat, id: \.id) { cat in
                        ZStack {
                            AsyncImage(url: URL(string: cat.tileUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 160, height: 100)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 160, height: 100)
                                        .clipped()
                                case .failure:
                                    Color.gray
                                        .frame(width: 160, height: 100)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 160, height: 100)
                            .cornerRadius(18)
                            
                            
                            Text(cat.categoryName)
                                .foregroundColor(.white)
                                .bold()
                                .shadow(radius: 10)
                                .padding(8)
                                .cornerRadius(5)
                        }
                        .padding(.leading)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear {
                loadCat()
            }
        }
        
    }
    
    private func loadCat() {
        Task {
            do {
                self.workoutCat =  try await apiService.listCategories()
            } catch {
                print("caanot load categories \(error)")
            }
        }
    }
}

#Preview {
    CategoryView()
}
