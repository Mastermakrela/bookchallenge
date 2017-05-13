//
//  GlobalVariables.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 07/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import Foundation

var userID: Int = 1

// Universal category codes
var categoryNumber = [
    "All" : "-1",
    "To Read" : "0",
    "Started" : "1",
    "Finished" : "2",
    "Recommended" : "3" // NOT IMPLEMENTED ON SERVER SIDE
]

let categories = ["To Read", "Started", "Finished"]

// TODO - Implement Remember Me feature
/*
struct rememberMe {
    static var username = ""
    static var password = ""
    static var remember = false
}



class Global {
    
    // MARK: Save rememberMe
    private struct rememberMeKeys {
        static let usernameKey = "usernameKey"
        static let passwordKey = "passwordKey"
        static let rememberKey = "rememberKey"
    }
    
    static func saveRememberMe(){
        UserDefaults.standard.set(rememberMe.username, forKey: rememberMeKeys.usernameKey)
        UserDefaults.standard.set(rememberMe.password, forKey: rememberMeKeys.passwordKey)
        UserDefaults.standard.set(rememberMe.remember, forKey: rememberMeKeys.rememberKey)
    }
    
    
}
*/
