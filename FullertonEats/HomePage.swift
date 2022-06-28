//
//  HomePage.swift
//  FullertonEats
//
//  Created by csuftitan on 6/27/22.
//

import Foundation
import SwiftUI

struct Navigator: View {
    @EnvironmentObject var user: User

    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            MyEventsView()
                .tabItem {
                    Image(systemName: "square.text.square.fill")
                    Text("My Events")
                }
            FavoritedEventsView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Favorited Events")
                }
            // Insert View here
        }
        .background(.white)
        .hiddenNavigationBarStyle()
    }
}

struct HomePage: View {
    @EnvironmentObject var user: User

    var body: some View {
        ZStack {
            BackgroundDesign()
        }
        .hiddenNavigationBarStyle()
    }
}
