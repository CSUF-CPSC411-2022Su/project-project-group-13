//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import SwiftUI

struct ContentView: View {
    @State var serviceManager = ServiceManager()
    
    var body: some View {
        GeometryReader { geometry in
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
                }.frame(height: geometry.size.height / 12)
                
                List {
                    ForEach(serviceManager.serviceList, id: \.self) { service in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(service.label)
                                    .fontWeight(.semibold)
                                    .minimumScaleFactor(0.5)
                                
                                Text(service.date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text(service.time)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer().frame(width: 160)
                            Image(systemName: "info.circle")
                        }
                    }
                }.frame(height: geometry.size.height / 1.3)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
