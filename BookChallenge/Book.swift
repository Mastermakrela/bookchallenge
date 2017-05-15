//
//  Book.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 06/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import Foundation

class Book {
    
    var title: String
    var author: String
    var id: String
    var startDate: String
    var endDate: String
    var status: String
    
    
    
    init?(title: String, author: String, id: String, startDate: String, endDate: String, status: String){
        self.title = title
        self.author = author
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
    
    var timeSpent: Int {
        
        if status == "0" {
            return 0
        }else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let calendar = Calendar.current
            let start = calendar.startOfDay(for: dateFormatter.date(from: startDate)!)
            
            if endDate == "0000-00-00" {
                let end = Date.init()
                let components = calendar.dateComponents([.day], from: start, to: end)
                
                return components.day!
            }else {
                let end = calendar.startOfDay(for: dateFormatter.date(from: endDate)!)
                
                let components = calendar.dateComponents([.day], from: start, to: end)
                return components.day!
            }
            
        }
        
    }
    
}
