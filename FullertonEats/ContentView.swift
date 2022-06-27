//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//New pull today 

import SwiftUI

struct ContentView: View {
    @State var searchString: String = ""
    @StateObject var finder = FoodFinder()
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Find Food Location ", text: $searchString)
                .modifier(TextEntry())
            
            Button(action: {
                finder.find(searchString)
            }) {
                Label("Search", systemImage: "magnifyingglass.circle.fill")
            }
            .modifier(myButtonDesign())
            .padding(.bottom, 20)

            Text("Search result")
                .font(.largeTitle)
                .foregroundColor(Color.orange)
            Text(finder.firstFoundName)
                .font(.body)
                .foregroundColor(Color.blue)
            Image(uiImage: finder.image)
            Spacer()
        }.padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
