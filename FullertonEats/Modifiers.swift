//
//  ServiceModifiers.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/16/22.
//

import SwiftUI

struct HeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .foregroundColor(.black)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(.CSUFOrange())
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .font(.headline)
            .foregroundColor(.white)
    }
}


//Jiu Lin' struct
struct TextEntry: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .border(Color.blue)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(8)
    }
}

struct myButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .padding()
            .font(.headline)
            // .background(Color(red: 0.8823529411764706, green: 0.4392156862745098, blue: 0.0))
            .background(Color.blue)
            .foregroundColor(Color.orange)
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
    }
}
