//
//  HomePage.swift
//  FullertonEats
//
//  Created by csuftitan on 6/27/22.
//

import Foundation
import SwiftUI

struct Navigator: View {
    @StateObject var user: User

    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(user)
            MyEventsView()
                .tabItem {
                    Image(systemName: "square.text.square.fill")
                    Text("My Events")
                }
                .environmentObject(user)
            FavoritedEventsView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Favorited Events")
                }
                .environmentObject(user)
            mapView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .environmentObject(user)
        }
        .background(.white)
        .hiddenNavigationBarStyle()
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct HomePage: View {
    @EnvironmentObject var user: User

    @State var myEventLabel = ""
    @State var myEventAddress = ""
    @State var myEventDate = ""
    @State var favEventLabel = ""
    @State var favEventAddress = ""
    @State var favEventDate = ""
    var emptyMyEvent = "You have no upcoming events from My Events."
    var emptyFavEvent = "You have no upcoming events from Favorited Events."

    var dateFormat = DateFormatter()
    var timeFormat = DateFormatter()

    init() {
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
    }

    var body: some View {
        ZStack {
            BackgroundDesign()

            VStack(alignment: .leading) {
                Text("Upcoming Events")
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .shadow(radius: 5)
                
                Text("My Events")
                    .foregroundColor(.white)
                    .font(.title3)
                    .shadow(radius: 5)
                
                if user.myEvents.count > 0 {
                    EventView(text: myEventLabel, address: myEventAddress, date: myEventDate)
                } else {
                    EventView(text: emptyMyEvent, address: "", date: "")
                }
                
                Text("Favorited Events")
                    .foregroundColor(.white)
                    .font(.title3)
                    .shadow(radius: 5)

                if user.favoritedEvents.count > 0 {
                    EventView(text: favEventLabel, address: favEventAddress, date: favEventDate)
                } else {
                    EventView(text: emptyFavEvent, address: "", date: "")
                }
            }
        }
        .onAppear {
            if let myEvent = user.getUpcomingMyEvent() {
                myEventLabel = myEvent.label
                myEventAddress = myEvent.address
                myEventDate = dateFormat.string(from: myEvent.date)
            }

            if let favEvent = user.getUpcomingFavoriteEvent() {
                favEventLabel = favEvent.label
                favEventAddress = favEvent.address
                favEventDate = dateFormat.string(from: favEvent.date)
            }
        }
        .hiddenNavigationBarStyle()
    }
}

// Displays a given Event
struct EventView: View {
    var text: String
    var address: String
    var date: String
    var desc = ""

    init(text: String, address: String, date: String) {
        self.text = text
        self.address = address
        self.date = date
        self.desc = "\(address) | \(date)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.headline)

            if !address.isEmpty, !date.isEmpty {
                Text(desc)
                    .font(.subheadline)
            }
        }
        .modifier(HomePageEventModifier())
    }
}
