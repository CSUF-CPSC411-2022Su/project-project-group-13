//
//  mapAPI_bad.swift
//  FullertonEats
//
//  Created by csuftitan on 6/20/22.
//

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
    //@State var address: String = ""
    @State var mapAPIs = [
        mapAPIStorage(ip: 12345678, address: "Fullerton College Ave, Fullerton , CA 91000"),
        mapAPIStorage(ip: 12345699, address: "Diamand Bar Ave, Orange, CA 12345")
    ]
    
    var body: some View {
        // GeometryReader { geometry in
        // NavigationView {
        
        VStack {
            ForEach(mapAPIs)
            {
                aItem in
                HStack {
                    Text(" \(mapAPIs.address)")
                }
            }
            
            /*
            List {
                Section(header: Text("You select following address")) {
                    NavigationLink(destination: Text("Fullerton College Ave, Fullerton , CA 91000") {
                        Text("Address name 1 But")
                    }
                    NavigationLink(destination: Text("Diamand Bar Ave, Orange, CA 12345") {
                        Text("Address name 2 But")
                    }
                }
               */
                
            }// end of VStack
            // Spacer()
        }
        //   }.frame(height: geometry.size.height/1)
        //  }// geometry reader
    }
}


// mapAPI
class mapAPIStorage: ObservableObject, Identifiable
{
    @Published var ip: Int
    @Published var address: String
    
    init (ip: Int, address: String)
    {
        self.ip = ip
        self.address = address
    }
    
    func displayInfo()
    {
        print("\(address)")
    }
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
