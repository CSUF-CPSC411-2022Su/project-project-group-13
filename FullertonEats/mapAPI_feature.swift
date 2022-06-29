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

// Address name and location's image (decode API info view )
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
            Image("map0")
                .frame(alignment: .center)
            NavigationLink(destination: nextPage()) {
                Text("More Information")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

// More information view (List view)
struct nextPage: View {
    var body: some View {
        VStack(spacing: 0) {
            Label(" More Free Food Information Coming Soon...", systemImage: "leaf.fill")
                .imageScale(.medium)
                .foregroundColor(Color.gray)
                .font(.body)

            // List Session View
            List {
                // Session_1
                Section(header: Text("Note")) {
                    NavigationLink(destination: detailInfo()) {
                        Text("Pick Up Note").foregroundColor(Color.blue)
                    }
                }
                // Session_2
                Section(header: Text("Services")) {
                    NavigationLink(destination: Text("We provide free food pick up. More free food pick events will be posted soon. A fixed pick-up time will be Monday 8:30 am - 3:30 pm, Friday  8:30 am - 3:30 pm.")) {
                        Text("Announcements").foregroundColor(Color.blue)
                    }
                    DisclosureGroup(content: {
                        NavigationLink(destination: Text("123-456-789")) {
                            Text("Phone").foregroundColor(Color.blue)
                        }
                        NavigationLink(destination: Text("place_123@gmail.com")) {
                            Text("Email").foregroundColor(Color.blue)
                        }
                    }) {
                        Text("Helps") // For DisclosureGroup
                    }
                }
            }
            Spacer()
        }
    }
}

// Taking Note View (click "Pick UpNote" )
struct detailInfo: View {
    // @State var note: String = ""
    @SceneStorage("note") var note: String = ""

    var body: some View {
        VStack {
            HStack {
                Label("Foods/Places Note:", systemImage: "pencil")
                    .font(Font.title3.bold())
                    .foregroundColor(Color(red: 0.0, green: 0.15294117647058825, blue: 0.2980392156862745))
                    .imageScale(.large)

                heartShape()
                    .fill(.blue)
                    .frame(width: 23, height: 19)
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

// Self defined shape (small blue heart)
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

struct Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
