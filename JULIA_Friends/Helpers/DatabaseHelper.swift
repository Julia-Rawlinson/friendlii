//
//  DatabaseHelper.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import Foundation
import Firebase

class DatabaseHelper : ObservableObject {
    
    @Published var list = [Friend]()
    let db = Firestore.firestore()
    
    public func addFriend(name: String, email: String, phone: String, city: String, country: String){
        let newFriend = db.collection("friends").document()
        newFriend.setData([
            "name" : name,
            "email" : email,
            "phone" : phone,
            "city" : city,
            "country" : country
        ]){ error in
            if let error = error {
                print("Error creating document: \(error)")
            } else {
                print("Document successfully created")
            }
        }
    }
    /*
    public func getAllFriends() {
        db.collection("friends").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            DispatchQueue.main.async {
                self.list = documents.map { d in
                        return Friend(
                            id: d.documentID,
                            name: d["name"] as? String ?? "",
                            email: d["email"] as? String ?? "",
                            phone: d["phone"] as? String ?? "",
                            city: d["city"] as? String ?? "",
                            country: d["country"] as? String ?? ""
                        )
                }
            }
        }
    }
     */
    
    public func getAllFriends() {
        db.collection("friends")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                //Update in the main thread
                DispatchQueue.main.async {
                    self.list = documents.map { d in
                        //Return each friend
                        return Friend(
                            id: d.documentID,
                            name: d["name"] as? String ?? "",
                            email: d["email"] as? String ?? "",
                            phone: d["phone"] as? String ?? "",
                            city: d["city"] as? String ?? "",
                            country: d["country"] as? String ?? ""
                        )
                    }
                }

            }
    }
    

    
    
}
