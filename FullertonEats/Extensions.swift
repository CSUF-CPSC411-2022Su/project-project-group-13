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

extension Service: Hashable {
    static func == (lhs: Service, rhs: Service) -> Bool {
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
