//
//  ContentView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    private let db = DatabaseHelper()
    private let loc = LocationHelper()
    @State var selection: Int? = nil
    @State private var errorMessage : String = "Standard error"
    @State private var inputError : Bool = false
    @State private var obtainedCoordinates : CLLocation?
    @State private var obtainedCode : String?
    //@State private var result : String = ""
    
    @State private var tvName : String = ""
    @State private var tvEmail : String = ""
    @State private var tvPhone : String = ""
    @State private var tvStreet : String = ""
    @State private var tvCity : String = ""
    @State private var tvCountry : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FriendsView(), tag: 1, selection: $selection){}
                Form {
                    Section(header: Text("Friend Info")) {
                        TextField("Full Name", text: $tvName)
                        TextField("Email", text: $tvEmail).keyboardType(.emailAddress)
                        TextField("Phone", text: $tvPhone).keyboardType(.phonePad)
                        TextField("Street Address", text: $tvStreet)
                        TextField("City", text: $tvCity)
                        TextField("Country", text: $tvCountry)
                    }
                    
                    Button (action: {
                        if(true/*self.isInputValid()*/){
                            /*
                            db.addFriend(
                                    name: tvName,
                                    email: tvEmail,
                                    phone: tvPhone,
                                    city: tvCity,
                                    country: tvCountry
                                )
                             */
                            let address = "\(self.tvStreet), \(self.tvCity), \(self.tvCountry)"
                            self.addNewFriend(address: address)
                            
                        }
                        
                    }){
                        HStack {
                            Spacer()
                            Text("Press here to test")
                            Spacer()
                        }
                    }
                    .padding()
                    
                }
            }
            .navigationBarTitle("Add a Friend")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(
                trailing: Button(
                    action: {
                        //Navigate to ListView
                        print(#function, "Navigate to FriendsView")
                        self.selection = 1
                    }) {
                    Text("Friend List")
                }
            )
        }
        .alert(isPresented: self.$inputError){
            Alert(
                //Create bad input alert
                title: Text("Invalid Order"),
                message: Text(errorMessage),
                dismissButton: .default(Text("Close"), action: {self.errorMessage = ""}
                )
            )
        } // Button

    }
    
    private func addNewFriend(address: String) {
        
        self.loc.doGeocoding(address: address, completionHandler: { (coordinates, code, error) in
            
            if (error == nil && coordinates != nil && code != nil){
                //sucessfully obtained coordinates
                self.obtainedCoordinates = coordinates!
                self.obtainedCode = code!
                self.db.addFriend(name: tvName, email: tvEmail, phone: tvPhone, city: tvCity, country: tvCountry, lat: self.obtainedCoordinates!.coordinate.latitude, lon: self.obtainedCoordinates!.coordinate.longitude, isoCountryCode: self.obtainedCode!)
                
                print(#function, "Coordinates obtained\nLat: \(coordinates!.coordinate.latitude) \nLng: \(coordinates!.coordinate.longitude)")
            }else{
                //The location could not be resolved
                self.errorMessage = "The coordinates of the provided address could not be resolved"
                self.inputError = true
                print(#function, "error: ", error?.localizedDescription as Any)
            }
        })
        
    }
    
    
    private func isInputValid() -> Bool {
        
        //Check no fields are empty (I want email to be manditory also)
        if(tvName.isEmpty || tvEmail.isEmpty || tvPhone.isEmpty || tvCity.isEmpty || tvCountry.isEmpty){
            print(#function, "At least one field is empty")
            return false
        }
        
        //Check that email is of good format
        if(!self.isEmailValid(email: tvEmail)){
            print(#function, "Email is of improper format")
            return false
        }
        
        //Check that the phone is 10-12 chars only
        if(!self.isPhoneValid(phone: tvPhone)){
            print(#function, "Phone is of improper format")
            return false
        }
    
        return true
    }
    
    private func isPhoneValid(phone: String) -> Bool {
        if(phone.count >= 10 && phone.count <= 12){
            return true
        }
        return false
    }
    
    private func isEmailValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
