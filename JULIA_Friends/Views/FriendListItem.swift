//
//  FriendListItem.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-24.
//

import SwiftUI

struct FriendListItem: View {
    let friend: Friend
    let imageSize: CGFloat = 100
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://flagcdn.com/80x60/\(friend.isoCountryCode.lowercased()).png")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                } else if phase.error != nil {
                    Text(phase.error?.localizedDescription ?? "error")
                        .foregroundColor(Color.pink)
                        .frame(width: imageSize, height: imageSize)
                        .font(.system(size: 12))
                } else {
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(friend.name)
                    .font(.headline)
                Text(friend.phone)
                Text(friend.email)
            }
        }
    }
}

struct FriendListItem_Previews: PreviewProvider {
    static var previews: some View {
        FriendListItem(friend: Friend())
    }
}
