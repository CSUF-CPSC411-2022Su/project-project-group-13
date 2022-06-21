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

struct TextLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, alignment: .trailing)
            .padding(.leading, 10)
            .foregroundColor(Color.white)
    }
}

struct TextBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 250, alignment: .trailing)
            .padding(.leading, 10)
            .background(Color.white)
    }
}

struct RoundedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(10)
    }
}

struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(RoundedBackground())
            .foregroundColor(Color.white)
    }
}

