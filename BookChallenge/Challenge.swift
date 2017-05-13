//
//  Challenge.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 17.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit

class Challenge: NSObject, NSCoding {
    
    // MARK: Properties
    var id: Int
    var name: String
    var done: Bool
    
    
    // MARK: Archiving paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("challenges")
    
    
    // MARK: Types
    struct PropertyKey {
        
        static let nameKey = "name"
        static let doneKey = "done"
        static let idKey = "key"
    }
    
    
    // MARK: Initialization
    init?(id: Int, name: String, done: Bool = false){
        
        //Initialize properties
        self.id = id
        self.name = name
        self.done = done
        
        if name.isEmpty {
            return nil
        }
    }
    
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(done, forKey: PropertyKey.doneKey)
        aCoder.encode(id, forKey: PropertyKey.idKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let done = aDecoder.decodeBool(forKey: PropertyKey.doneKey)
        let id = aDecoder.decodeObject(forKey: PropertyKey.idKey) as! Int
        
        self.init(id: id, name: name, done: done)
        
    }
    
}
