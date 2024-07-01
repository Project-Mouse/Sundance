//
//  KeepMeUpdated.swift
//  Sundance
//
//  Created by Imran razak on 29/06/2024.
//

import SwiftUI

struct KeepMeUpdated: View {
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var errorMessage: String = ""
    @State private var showSuccess: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack {
              
                
                VStack(spacing: 5){
                    Text("📧")
                        .font(.system(size: 100))
                    
                    
                    Text("Keep me updated")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                    
                    Text("We’ve love for you to hear from us when we do allow more people onto the Limited Release.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(spacing: 10) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    Text("To Sign in you need an Invite. If you have not received an invite you won't be able to sign in.")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing])
                }
              
                
                Spacer()
                
                Button {
               
                } label: {
                    Text("Notify me")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color("SundanceBlue"))
                .cornerRadius(18)
                .shadow(radius: 10)
                .padding([.leading, .trailing])
            }
            .background(Color("SunshineYellow"))
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
        .fullScreenCover(isPresented: $showSuccess){
            HomeView()
        }
    }
}
#Preview {
    KeepMeUpdated()
}
