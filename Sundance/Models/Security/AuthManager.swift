//
//  AuthManager.swift
//  Sundance
//
//  Created by Imran razak on 22/06/2024.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.session = user
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

