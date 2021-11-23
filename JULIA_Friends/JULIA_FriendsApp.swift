//
//  JULIA_FriendsApp.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI
import Firebase

@main
struct JULIA_FriendsApp: App {
    
    init(){
        //Set up firebase at launch
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

