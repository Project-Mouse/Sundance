//
//  SignInView.swift
//  Sundance
//
//  Created by Imran razak on 22/06/2024.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authManager: AuthManager
    @State private var showingAlert = false
    @State private var errorMessage: String = ""
    @State private var showHome: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("👋")
                    .font(.system(size: 100))
                
                VStack(spacing: 10){
                    Text("Sign In")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text("To Sign in you need an Invite. If you have not received an invite you won't be able to sign in.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .padding()
                
                VStack(spacing: 20) {
                    TextField("Email", text: $username)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                Button(action: signIn) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color("SunshineYellow"))
                .cornerRadius(18)
                .shadow(radius: 10)
                .padding([.leading, .trailing])
            }
            .background(Color("SundanceBlue"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        
        
        
        
        
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Sign In Error"),
                message: Text(errorMessage),
                primaryButton: .default(Text("Contact Us"), action: {
                    // Implement your contact support action here
                    print("Contact support tapped")
                }),
                secondaryButton: .default(Text("OK"))
            )
        }
        .fullScreenCover(isPresented: $showHome){
            HomeView()
        }
    }
    
    private func signIn() {
        authManager.signIn(email: username, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showingAlert = true
                print("Error signing in: \(error.localizedDescription)")
            } else {
                print("Sign in successful")
                // Handle successful sign-in (e.g., navigate to another view)
                showHome = true
            }
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthManager())
}
