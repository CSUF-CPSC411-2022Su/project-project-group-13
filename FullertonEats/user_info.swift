//
//  user_info.swift
//  FullertonEats
//
//  Created by csuftitan on 6/13/22.
//

import Foundation

class UserInfo {
    var username: String?
    var password: String?
    var email: String?
    
    init(username: String?, password: String?, email: String?){
        self.username = username
        self.password = password
        self.email = email
    }
}
