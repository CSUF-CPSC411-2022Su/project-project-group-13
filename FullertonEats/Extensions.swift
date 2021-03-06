//
//  Extensions.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/17/22.
//

import SwiftUI

extension Color {
    static func CSUFBlue() -> Color {
        return Color(red: 0, green: 39/255, blue: 76/255)
    }

    static func CSUFOrange() -> Color {
        return Color(red: 225/255, green: 112/255, blue: 0)
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension Event: Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.label == rhs.label &&
            lhs.desc == rhs.desc &&
            lhs.address == rhs.address &&
            lhs.date == rhs.date &&
            lhs.startTime == rhs.startTime &&
            lhs.endTime == rhs.endTime
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(desc)
        hasher.combine(address)
        hasher.combine(date)
        hasher.combine(startTime)
        hasher.combine(endTime)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier(HiddenNavigationBar())
    }
}
