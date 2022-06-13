//
//  Services.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/11/22.
//

import SwiftUI

struct Service {
    var label: String
    var desc: String
    var address: String
    var date: DateComponents
    var time: DateComponents
    
    // with description
    init(label: String, desc: String, address: String, date: DateComponents, time: DateComponents) {
        self.label = label
        self.desc = desc
        self.address = address
        self.date = date
        self.time = time
    }
    
    // no description
    init(label: String, address: String, date: DateComponents, time: DateComponents) {
        self.label = label
        self.desc = ""
        self.address = address
        self.date = date
        self.time = time
    }

}

class Services {
    
    var myServices: [Service] = []
    
    init() {}
    
    func addService(service: Service) {
        myServices.append(service)
    }
    
}
