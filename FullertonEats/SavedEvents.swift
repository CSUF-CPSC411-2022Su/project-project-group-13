//
//  SavedEvents.swift
//  FullertonEats
//
//  Created by csuftitan on 6/22/22.
//

import SwiftUI

struct SavedEvents: View {
    @State private var eventContact = ""
    @State private var addressSave = ""
    @State private var eventDate = ""
    @State private var eventShortDetails = ""
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                Circle()
                    .scale(1.35)
                    .foregroundColor(.orange)
            VStack { // Stacking text saved text frames on top of each other
                VStack{
                    Text("Insert event address here")
                    Text("Insert event date here")
                    Text("Insert event contact here")
                }
                .frame(width: 350, height:100, alignment:.leading)
                .background(Color.gray)
                .cornerRadius(10)
                Spacer()
                Button("Add to Saved List   +"){
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }
}
}
struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedEvents()
    }
}
