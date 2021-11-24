//
//  FriendsView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI

struct FriendsView: View {
    
    @ObservedObject private var helper = DatabaseHelper()
    
    init(){
        helper.getAllFriends()
    }
    
    var body: some View {
        if(!(helper.list.count == 0)){
            List(helper.list, id: \.self){ item in
                
                VStack {
                    Text(item.name)
                    Text(item.email)
                    Text(item.phone)
                    Text(item.city)
                    Text(item.country)
                }
                
            }
        } else {
            Text("You are friendless and will die alone")
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
