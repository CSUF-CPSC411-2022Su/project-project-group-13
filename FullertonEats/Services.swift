//
//  Services.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/11/22.
//

import SwiftUI

struct Service: Codable {
    var label: String
    var desc: String
    var address: String
    var date: Date
    var startTime: Date
    var endTime: Date

    init(label: String, desc: String, address: String, date: Date, startTime: Date, endTime: Date) {
        self.label = label
        self.desc = desc
        self.address = address
        self.date = date
        self.startTime = date
        self.endTime = date
    }
    
    mutating func update(label: String, desc: String, address: String, date: Date, startTime: Date, endTime: Date) {
        self.label = label
        self.desc = desc
        self.address = address
        self.date = date
        self.startTime = date
        self.endTime = date
    }
}
