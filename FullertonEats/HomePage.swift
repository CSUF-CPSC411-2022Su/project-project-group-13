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
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct HomePage: View {
    @EnvironmentObject var user: User

    @State var myEventLabel = ""
    @State var favEventLabel = ""
    @State var myEventDate = ""
    @State var favEventDate = ""
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
                if user.myEvents.count > 0 {
                    EventView(text: myEventLabel, date: myEventDate)
                } else {
                    EventView(text: "You have no upcoming events from My Events.", date: "")
                }

                if user.favoritedEvents.count > 0 {
                    EventView(text: favEventLabel, date: favEventDate)
                } else {
                    EventView(text: "You have no upcoming events from Favorited Events.", date: "")
                }
            }
        }
        .onAppear {
            if let myEvent = user.getUpcomingMyEvent() {
                myEventLabel = myEvent.label
            }

            if let favEvent = user.getUpcomingFavoriteEvent() {
                favEventLabel = favEvent.label
            }
        }
        .hiddenNavigationBarStyle()
    }
}

struct EventView: View {
    @State var text = ""
    @State var date = ""
    
    init(text: String, date: String) {
        self.text = text
        self.date = date
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.headline)
            
            if !date.isEmpty {
                Text(date)
                    .font(.subheadline)
            }
            
        }
        .modifier(HomePageEventModifier())
    }
}
