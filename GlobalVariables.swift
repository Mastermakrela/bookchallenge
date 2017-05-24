//
//  GlobalVariables.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 07/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import Foundation

var userID: Int = -1

// Universal category codes
var categoryNumber = [
    "All" : "-1",
    "To Read" : "0",
    "Started" : "1",
    "Finished" : "2",
    "Recommended" : "3" // NOT IMPLEMENTED ON SERVER SIDE
]

let categories = ["To Read", "Started", "Finished"]

// Remember data between sessions
let defaults = UserDefaults.standard
