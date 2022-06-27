//
//  mapAPI.swift
//  FullertonEats
//
//  Created by csuftitan on 6/20/22.
//

/*
import SwiftUI
import Foundation


struct informationView: View {
    //@State var ip: Int = 0
    // @State var address: String = "Fullerton College Ave, Fullerton , CA 91000"
    @State var places = [
        mapAPIBank(ip:12333, address: "Fullerton College Ave, Fullerton , CA 91000" ),
        mapAPIBank(ip:12666, address: "Diamand Bar Ave, Orange, CA 12345" ),
        mapAPIBank(ip:12888, address: "Rosemead Blvd, Los Angles, CA 12345" )
    ]
    
    var body: some View {
        // GeometryReader { geometry in
        // NavigationView {
        VStack {
            
            List(places) {
                place in
                Text(place.address)
                /*
                 Section(header: Text("You select following address")) {
                 
                 NavigationLink(destination: Text("\(place.address)"){
                 Text("Address name 1 But")
                 }
                 */
            }
        }
    }
    //   }.frame(height: geometry.size.height/1)
    //  }// geometry reader
}



// mapAPI
struct mapAPIBank: Identifiable {
    var id = UUID()
    var ip: Int
    var address: String
}



// An array of ddress Class, to store the many address inside the array
class addressSelected: ObservableObject {    // return string
    
    @Published var addressArr: [Address] = []
    
    var addressNum: Int { // what is volunteerList ???? string function  ? computed property
        var num : Int = 0
        
        if !addressArr.isEmpty {
            for item in addressArr {
                num += 1
            }
        }
        
        return num // no address selected what is List ????   string array ?
    }
    
    init() {}
}



//Address class
class Address
{
    @Published var place: String
    @Published var phone: String
    @Published var openTime: String
    @Published var closeTime: String
    
    init(place: String, phone: String, openTime: String, closeTime: String ) {
        self.place = place
        self.phone = phone
        self.openTime = openTime
        self.closeTime = closeTime
    }
}


*/
