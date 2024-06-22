//
//  ContentView.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if authManager.session != nil {
                HomeView()
            } else {
                LimitedView()
            }
        }
    }
}

#Preview {
    ContentView()
}
