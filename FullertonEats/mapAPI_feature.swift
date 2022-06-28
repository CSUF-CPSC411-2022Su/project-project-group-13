//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//  Edit by Jiu Lin on 6/26/22

import SwiftUI

struct mapView: View {
    @StateObject var finder = FoodFinder()
    @SceneStorage("searchString") var searchString: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Find Food Location ", text: $searchString)
                .modifier(TextEntry())

            Button(action: {
                finder.find(searchString)
            }) {
                Label("Search", systemImage: "magnifyingglass.circle.fill")
            }
            .modifier(myButtonDesign())
            .padding(.bottom, 20)

            Label("Search result", systemImage: "takeoutbag.and.cup.and.straw.fill")
                .imageScale(.small)
                .font(.largeTitle)
                .foregroundColor(Color.orange)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(uiImage: finder.image)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(finder.firstFoundName)
                .font(.body)
                .foregroundColor(Color.blue)
                .frame(maxWidth: .infinity, alignment: .center)

            NavigationView {
                NavigationLink(destination: firstView()) {
                    Text("Next page")
                    // firstView()
                }
            }

            Spacer()
        }.padding()
    }
}

struct firstView: View {
    @State var address: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to use our app")
                .foregroundColor(.orange)

            Spacer()
        }.padding()
        TabView{
            //
        }
    }
}


struct Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

