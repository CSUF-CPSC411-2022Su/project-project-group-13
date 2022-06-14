//
//  Services.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/11/22.
//

import Foundation

struct Service {
    var label: String
    var desc: String
    var address: String
    var date: String
    var time: String
}

extension Service: Hashable {
    static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.label == rhs.label && lhs.desc == rhs.desc
        && lhs.address == rhs.address && lhs.date == rhs.date
        && lhs.time == rhs.time
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(desc)
        hasher.combine(address)
        hasher.combine(date)
        hasher.combine(time)
    }
}


struct ServiceManager {
    
    private(set) var serviceList: [Service] = []
}
