//
//  LimitedView.swift
//  Sundance
//
//  Created by Imran razak on 22/06/2024.
//

import SwiftUI

struct LimitedView: View {
    @State private var showSignIn = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(height: geometry.size.height * 0.55) // Adjust this factor to change the rectangle's height
                    .ignoresSafeArea(edges: .top)
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Sundance")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    Text("Made for the Everyday Pro.\n10 Mins.\nThat's all you need.")
                        .multilineTextAlignment(.center)
                    
                    Button {
                        showSignIn = true
                    } label: {
                        Text("I have an Invite")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color.blue)
                            .cornerRadius(18)
                    }
                    .shadow(radius: 10)
                    
                    Button {
                        // Action for "Keep me Updated" button
                    } label: {
                        Text("Keep me Updated")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(.skyBlue)
                            .cornerRadius(18)
                    }
                    
                    Text("We're currently on a limited release. That means you need to be invited to sign in. You can still sign up to keep yourself updated.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .padding(.horizontal)
                }
                .padding(.top, -50) // This moves the content up, overlapping with the rectangle
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .edgesIgnoringSafeArea(.bottom)
                )
                
                Spacer()
            }
        }
        .sheet(isPresented: $showSignIn) {
            SignInView()
        }
    }
}

// Helper extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    LimitedView()
}
