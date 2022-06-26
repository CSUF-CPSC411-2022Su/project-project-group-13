//
//  User.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/18/22.
//

import SwiftUI

class User: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case username, password, favoritedServices, myServices
    }
    
    var username: String
    var password: String
    @Published var favoritedServices: [Service] = []
    @Published var myServices: [Service] = []
    
    init() {
        self.username = ""
        self.password = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
        favoritedServices = try container.decode([Service].self, forKey: .favoritedServices)
        myServices = try container.decode([Service].self, forKey: .myServices)
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    
        myServices.append(Service(label: "Hot Dogs", desc: "Free hot dogs! With condiments.", address: "Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        myServices.append(Service(label: "Burgers", desc: "Vegan burgers!", address: "Gymnasium Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        myServices.append(Service(label: "Tacos", desc: "Beef or chicken!", address: "Engineering and Computer Science Buildings, Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedServices.append(Service(label: "Bread and Water", desc: "All types of bread and water", address: "Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedServices.append(Service(label: "Soup", desc: "Tomato and chicken noodle soup!", address: "Gymnasium Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedServices.append(Service(label: "Fruits", desc: "All types of fruit served here!", address: "Engineering and Computer Science Buildings, Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
        try container.encode(favoritedServices, forKey: .favoritedServices)
        try container.encode(myServices, forKey: .myServices)
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
        var upcomingIndex = 0
        var min = 0.0
        
        min = Date.now - serviceArr[0].date
        for i in 1 ... serviceArr.count - 1 {
            let temp = Date.now - serviceArr[i].date
            
            if temp < min {
                min = temp
                upcomingIndex = i
            }
        }
        return upcomingIndex
    }
}

struct UserLoader {
    var userInfoURL: URL
    
    init() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        userInfoURL = documentDirectory.appendingPathComponent("userInfo").appendingPathExtension("plist")
    }
    
    // call this function on successful login
    func loadUser() -> User? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrieveUser = try? Data(contentsOf: userInfoURL), let decodedUser = try? propertyListDecoder.decode(User.self, from: retrieveUser) {
            return decodedUser
        }
        return nil
    }
    
    // call this function on user signup and service manipulation
    func saveUser(user: User) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedUser = try? propertyListEncoder.encode(user) {
            try? encodedUser.write(to: userInfoURL, options: .noFileProtection)
        }
    }
}
