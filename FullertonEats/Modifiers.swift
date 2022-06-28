//
//  Modifiers.swift
//  FullertonEats
//
//  Edit by Jiu Lin on 6/26/22

import Foundation
import SwiftUI

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
