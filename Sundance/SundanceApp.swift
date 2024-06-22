//
//  SundanceApp.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct SundanceApp: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [WorkoutModel.self, ProfileModel.self])
                .preferredColorScheme(.light)
                .environmentObject(AuthManager())
            
        }
    }
}
