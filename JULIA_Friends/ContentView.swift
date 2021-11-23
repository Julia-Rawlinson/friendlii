//
//  ContentView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tvName : String = ""
    @State private var tvEmail : String = ""
    @State private var tvPhone : String = ""
    private let db = DatabaseHelper()
    
    var body: some View {
        Form {
            Section {
                TextField("Full Name", text: $tvName)
                TextField("Email", text: $tvEmail)
                TextField("Phone", text: $tvPhone)
            }
            Button (action: {db.addFriend()}){
                Text("Press here to test")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
