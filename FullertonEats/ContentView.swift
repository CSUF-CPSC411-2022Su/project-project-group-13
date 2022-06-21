//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // NavigationView {
        // @StateObject var singleAddress = Address (place: "" , //phone: "", openTime: "", closeTime: "")
        VStack {
            NavigationView {
                NavigationLink(destination: firstView())
                {
                    Text ("Start to search ")
                }
            }
            // second Vstack
            // GeometryReader { geometry in
            NavigationView {
                NavigationLink(destination: informationView())
                {
                    Text ("See all address you selected. ")
                }
                //   }.frame(height: geometry.size.height/2)// Geomeotry reader end
            } // end of NavigationView
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //ContentView()
    }
}
