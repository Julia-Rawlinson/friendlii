//
//  FriendsView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI

struct FriendsView: View {
    
    @ObservedObject private var dbHelper = DatabaseHelper()
    private let baseUrl : String = "https://flagcdn.com/80x60/"
    private let imageHeight : Double = 0.0
    
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
    
    private func getImageUrl(code: String) -> URL? {
        guard let url = URL(string: String(baseUrl + code.lowercased() + ".png")) else {return nil}
        print(#function, url)
        return url
    }
    
    struct ListRow : View {
        let imageHeight : Double = 100
        let name : String
        let code : String
        
        var body : some View {
            Text("")
        }
        
    }
    
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
