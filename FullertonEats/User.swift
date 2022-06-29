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
    
    var username: String = ""
    var password: String = ""
    @Published var favoritedEvents: [Event] = []
    @Published var myEvents: [Event] = []
    
    init() {}
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
        favoritedEvents = try container.decode([Event].self, forKey: .favoritedEvents)
        myEvents = try container.decode([Event].self, forKey: .myEvents)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
        try container.encode(favoritedEvents, forKey: .favoritedEvents)
        try container.encode(myEvents, forKey: .myEvents)
    }
    
    // assign a loaded user to this user
    func assign(_ loadedUser: User) {
        username = loadedUser.username
        password = loadedUser.password
        favoritedEvents = loadedUser.favoritedEvents
        myEvents = loadedUser.myEvents
    }
    
    // returns the upcoming event from favoritedEvents
    func getUpcomingFavoriteEvent() -> Event? {
        if favoritedEvents.count == 0 {
            return nil
        } else if favoritedEvents.count == 1 {
            return favoritedEvents[0]
        }
        return getUpcoming(eventArr: favoritedEvents)
    }
    
    // returns the upcoming event from myEvents
    func getUpcomingMyEvent() -> Event? {
        if myEvents.count == 0 {
            return nil
        } else if myEvents.count == 1 {
            return myEvents[0]
        }
        return getUpcoming(eventArr: myEvents)
    }
    
    // Helper function, returns the upcoming event from an Event array
    private func getUpcoming(eventArr: [Event]) -> Event {
        var upcomingIndex = 0
        var max = 0.0
        
        max = Date.now - eventArr[0].date
        for i in 1 ... eventArr.count - 1 {
            let temp = Date.now - eventArr[i].date
            
            if temp >= max {
                max = temp
                upcomingIndex = i
            }
        }
        return eventArr[upcomingIndex]
    }
}

class UserLoader {
    var userInfoURL: URL
    
    init() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        userInfoURL = documentDirectory.appendingPathComponent("userInfo").appendingPathExtension("plist")
    }
    
    // call this function to load user
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
