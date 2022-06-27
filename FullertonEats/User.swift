//
//  User.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/18/22.
//

import SwiftUI

class User: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case username, password, favoritedEvents, myEvents
    }
    
    var username: String
    var password: String
    @Published var favoritedEvents: [Event] = []
    @Published var myEvents: [Event] = []
    
    init() {
        self.username = ""
        self.password = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
        favoritedEvents = try container.decode([Event].self, forKey: .favoritedEvents)
        myEvents = try container.decode([Event].self, forKey: .myEvents)
    }
    
    // sample init
    init(username: String, password: String) {
        self.username = username
        self.password = password
    
        myEvents.append(Event(label: "Hot Dogs", desc: "Free hot dogs! With condiments.", address: "Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        myEvents.append(Event(label: "Burgers", desc: "Vegan burgers!", address: "Gymnasium Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        myEvents.append(Event(label: "Tacos", desc: "Beef or chicken!", address: "Engineering and Computer Science Buildings, Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedEvents.append(Event(label: "Bread and Water", desc: "All types of bread and water", address: "Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedEvents.append(Event(label: "Soup", desc: "Tomato and chicken noodle soup!", address: "Gymnasium Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
        favoritedEvents.append(Event(label: "Fruits", desc: "All types of fruit served here!", address: "Engineering and Computer Science Buildings, Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
        try container.encode(favoritedEvents, forKey: .favoritedEvents)
        try container.encode(myEvents, forKey: .myEvents)
    }
    
    // returns the index of the upcoming event from favoritedEvents
    func getUpcomingFavoriteEvent() -> Int? {
        if favoritedEvents.count == 0 {
            return nil
        } else if favoritedEvents.count == 1 {
            return 1
        }
        return getUpcoming(eventArr: favoritedEvents)
    }
    
    // returns the index of the upcoming event from myEvents
    func getUpcomingMyEvent() -> Int? {
        if myEvents.count == 0 {
            return nil
        } else if myEvents.count == 1 {
            return 1
        }
        return getUpcoming(eventArr: myEvents)
    }
    
    // Helper function, returns the index of the upcoming event from an Event array
    private func getUpcoming(eventArr: [Event]) -> Int {
        var upcomingIndex = 0
        var min = 0.0
        
        min = Date.now - eventArr[0].date
        for i in 1 ... eventArr.count - 1 {
            let temp = Date.now - eventArr[i].date
            
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
    
    // call this function on user signup and event manipulation
    func saveUser(user: User) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedUser = try? propertyListEncoder.encode(user) {
            try? encodedUser.write(to: userInfoURL, options: .noFileProtection)
        }
    }
}
