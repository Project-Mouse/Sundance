//
//  ProfileSetup.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI
import SwiftData
import FirebaseFirestore

struct ProfileSetup: View {
    // Properties to hold profile information
    @State private var profileName: String = ""
    @State private var age: Int? // Make age optional to handle initial state
    @State private var gender: String = ""
    @State private var height: Double = 0.0
    @State private var weight: Double = 0.0
    @State private var selectedPurpose: String = "Loose Bum and Tum"
    
    
    //Purposes to select
    let purposeOptions = ["Loose Bum and Tum", "Feel Good", "Special Occasion", "For Myself"]
    
    // State to manage selected avatar
    @State private var selectedAvatar: String = ""
    
    // Avatar options
    let avatarOptions = ["Avatar1", "Avatar2", "Avatar3"] // Replace with actual image names or URLs
    
    // Gender options for the Picker
    let genderOptions = ["Male", "Female", "Other"]
    
    // State to manage alert presentation
    @State private var showAlert = false
    
    // Computed property to determine if all required fields are filled
    private var allFieldsFilled: Bool {
        !profileName.isEmpty && age != nil && !gender.isEmpty && height > 0.0 && weight > 0.0
    }
    
    
    
    
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(avatarOptions, id: \.self) { avatar in
                                Image(avatar) // Assumes the images are in the asset catalog
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                // .background(self.selectedAvatar == avatar ? Color.blue.opacity(0.3) : Color.green)
                                    .cornerRadius(10)
                                    .overlay(
                                        Group {
                                            if self.selectedAvatar == avatar {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.blue)
                                                   // .offset(x: 15, y: 15)
                                            }
                                        },
                                        alignment: .bottomTrailing
                                        
                                    )
                                    .onTapGesture {
                                        self.selectedAvatar = avatar
                                    }
                            }
                        }
                    }
                }
                
                
                Section(header: Text("Profile Information")) {
                    TextField("Profile Name", text: $profileName)
                    
                    TextField("Age", value: $age, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
                
                Section{
                    HStack {
                        Text("Height:")
                        Spacer()
                        TextField("Height (cm)", value: $height, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Weight:")
                        Spacer()
                        TextField("Weight (kg)", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section{
                    Picker("Reason for Working out", selection: $selectedPurpose){
                        ForEach(purposeOptions, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)

                }
            }
            .navigationTitle("Create a Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if self.allFieldsFilled {
                            // Proceed to next step
                            print("Proceed to next step")
                            saveProfileLocally()
                            saveProfileCloud()
                            
                        } else {
                            // Show alert if fields are not filled
                            self.showAlert = true
                        }
                    }) {
                        Text("Next")
                            .foregroundColor(.blue)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Incomplete Profile"),
                    message: Text("Please fill out all fields to proceed."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
        
    }
    
    private func saveProfileLocally() {
        var profile = ProfileModel(profileName: profileName,
                                   profileAvatar: selectedAvatar,
                                   profileAge: age ?? 13,
                                   profileGender: gender,
                                   profileHeight: height,
                                   profileWeight: weight)
        
        
        context.insert(profile)
        
    }
    
    private func saveProfileCloud() {
        let db = Firestore.firestore()
        
        let profileData: [String: Any] = [
            "profileName": profileName,
            "profileAvatar": selectedAvatar,
            "profileAge": age ?? 13,
            "profileGender": gender,
            "profileHeight": height,
            "profileWeight": weight
        ]
        
        db.collection("ProfileData").addDocument(data: profileData) { error in
            if let error = error {
                print("Error saving profile to Cloud: \(error.localizedDescription)")
            } else {
                print("Profile successfully saved to Cloud.")
            }
        }
    }
    
    
}


#Preview {
    ProfileSetup()
}
