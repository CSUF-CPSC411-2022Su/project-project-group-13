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

