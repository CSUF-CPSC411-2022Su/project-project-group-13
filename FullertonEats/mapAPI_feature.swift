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

            NavigationView {
                List {
                    ForEach(finder.arr, id: \.self) {
                        ii in

                        VStack {
                            NavigationLink(destination: infoo(foodlocation: ii)) {
                                Text(ii.place_name)
                            }
                        }
                    }
                }
            }
            Spacer()
        }.padding()
    }
}

struct infoo: View {
    var foodlocation: FoodLocactionInfo
    var body: some View {
        VStack {
            Text("Location Longitude: \(foodlocation.center[0])")
                .font(.headline)

            Text("Location Latitude: \(foodlocation.center[1])")
                .font(.headline)

            Text(" ")

            Text(foodlocation.place_name)
                .font(.headline)
                .foregroundColor(Color.blue)
            Image("map2")
                .frame(alignment: .center)
            NavigationLink(destination: nextPage()) {
                Text("More Information")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct nextPage: View {
    var body: some View {
        VStack {
            HStack {
                heartShape()
                    .fill(.blue)
                    .frame(width: 15, height: 15)
                Text("Some More Info Coming Soon...")
                    .foregroundColor(Color.gray)
                    .font(.title3)
                heartShape()
                    .fill(.blue)
                    .frame(width: 15, height: 15)
            }

            // List Session View
            List {
                Section(header: Text("Note")) {
                    NavigationLink(destination: detailInfo()) {
                        Text("Traveling Note").foregroundColor(Color.blue)
                    }
                }
                Section(header: Text("Services")) {
                    NavigationLink(destination: Text("No services provided. ")) {
                        Text("Services").foregroundColor(Color.blue)
                    }
                    DisclosureGroup(content: {
                        NavigationLink(destination: Text("123-456-789")) {
                            Text("Phone").foregroundColor(Color.blue)
                        }
                        NavigationLink(destination: Text("place_123.gmail.com")) {
                            Text("Email").foregroundColor(Color.blue)
                        }
                    }) {
                        Text("Helps")
                    }
                }
            }
            Spacer()
        }
    }
}

struct heartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX / 2, y: rect.maxY / 3)) // A
        path.addLine(to: CGPoint(x: rect.maxX * 2 / 3, y: 0)) // B
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 2)) // C
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY)) // D
        path.addLine(to: CGPoint(x: 0, y: rect.maxY / 2)) // E
        path.addLine(to: CGPoint(x: rect.maxX / 3, y: 0)) // F
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY / 3)) // A
        return path
    }
}

struct detailInfo: View {
    // @State var note: String = ""
    @SceneStorage("note") var note: String = ""

    var body: some View {
        VStack {
            HStack {
                heartShape()
                    .fill(.blue)
                    .frame(width: 25, height: 20)
                Text("Nice Location Note:  ")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.blue)
                heartShape()
                    .fill(.blue)
                    .frame(width: 25, height: 20)
            }
            TextField("Note:", text: $note)
                .foregroundColor(Color.black)
                .padding(2)
                .border(Color.black)
                .background(Color.white)
        }
        Spacer()
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
