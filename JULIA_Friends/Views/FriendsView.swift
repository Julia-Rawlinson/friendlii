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
        if(!(dbHelper.list.count == 0)){
            List(dbHelper.list, id: \.self){ item in
                FriendListItem(friend: item)
            }
        } else {
            Text("You are friendless and will die alone")
        }
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
