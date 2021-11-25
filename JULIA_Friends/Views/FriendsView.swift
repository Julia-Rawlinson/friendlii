//
//  FriendsView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI

struct FriendsView: View {
    
    @ObservedObject private var dbHelper = DatabaseHelper()
    
    init(){
        dbHelper.getAllFriends()
    }
    
    var body: some View {
        HStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("BrightPurple"), Color("Lavender")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(dbHelper.list, id: \.self) { item in
                            NavigationLink{
                                MapView(friend: item)
                            } label: {
                                FriendListItem(friend: item)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
