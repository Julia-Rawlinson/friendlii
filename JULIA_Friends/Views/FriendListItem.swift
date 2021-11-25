//
//  FriendListItem.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-24.
//

import SwiftUI

struct FriendListItem: View {
    let friend: Friend
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.3)
            HStack(){
                AsyncImage(url: URL(string: "https://flagcdn.com/80x60/\(friend.isoCountryCode.lowercased()).png")) { p in
                    if let image = p.image {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 50)
                            .clipped()
                    } else {
                        ProgressView()
                            .frame(width: 70, height: 50)
                    }
                }
                .padding(.leading, 30)
                
                VStack(alignment: .leading) {
                    Text(friend.name)
                        .font(.title2)
                    Spacer()
                        Label("\(friend.email)", systemImage: "mail")
                        .font(.subheadline)
                        Spacer()
                        Label("\(friend.phone)", systemImage: "phone")
                        .font(.subheadline)
                }
                .padding()
                .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}

struct FriendListItem_Previews: PreviewProvider {
    static var previews: some View {
        FriendListItem(friend: Friend(
            id: "", name: "Hello", email: "email@email.com", phone: "123 456 7890", city: "", country: "", lat: 0.0, lon: 0.0, isoCountryCode: "CA"
        ))
    }
}
