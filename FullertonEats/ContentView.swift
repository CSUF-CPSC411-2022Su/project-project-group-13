//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Button("Add", action: {
                    print("adding")
                }).foregroundColor(.orange)
                Spacer().frame(width: 270)
                Button("Edit", action: {
                    print("editing")
                }).foregroundColor(.orange)
            }
            HStack{
                Text("My Services")
                    .fontWeight(.bold)
                    .frame(width: 330, height: 25, alignment: .topLeading)
            }
            List(0..<5) { item in
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Label")
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.5)
                        
                        Text("January 1, 2021")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("6:00pm - 8:00pm")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer().frame(width: 160)
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
