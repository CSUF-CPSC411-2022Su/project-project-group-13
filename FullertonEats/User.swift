//
//  User.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/18/22.
//

import SwiftUI

class User: ObservableObject{
    var username: String
    var password: String
    @Published var favoritedServices: [Service] = []
    @Published var myServices: [Service] = []
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    // returns the index of the upcoming service from favoritedServices
    func getUpcomingFavoriteService() -> Int? {
        if favoritedServices.count == 0 {
            return nil
        } else if favoritedServices.count == 1 {
            return 1
        }
        return getUpcoming(serviceArr: favoritedServices)
    }
    
    // returns the index of the upcoming service from myServices
    func getUpcomingMyService() -> Int? {
        if myServices.count == 0 {
            return nil
        } else if myServices.count == 1 {
            return 1
        }
        return getUpcoming(serviceArr: myServices)
    }
    
    // Helper function, returns the index of the upcoming service from a service array
    private func getUpcoming(serviceArr: [Service]) -> Int {
        var upcomingIndex: Int = 0
        var min: Double = 0.0
        
        min = Date.now - serviceArr[0].date
        for i in 1...serviceArr.count - 1 {
            let temp = Date.now - serviceArr[i].date
            
            if temp < min {
                min = temp
                upcomingIndex = i
            }
        }
        return upcomingIndex
    }
}
