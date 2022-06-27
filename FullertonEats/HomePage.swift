//
//  HomePage.swift
//  FullertonEats
//
//  Created by csuftitan on 6/27/22.
//

import Foundation
import SwiftUI

struct BottomNavBar: View {
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
                    Text("My Events")
                }
            ContentView()
                .tabItem {
                    Text("Services")
                }
        }
        .background(.white)
    }
}

struct HomePage: View {
    var body: some View {
        ZStack {
            Color.CSUFBlue()
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white)
            Circle()
                .scale(1.35)
                .foregroundColor(.CSUFOrange())
        }
    }
}
