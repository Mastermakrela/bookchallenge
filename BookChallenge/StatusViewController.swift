//
//  StatusViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 08.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class StatusViewController: UIViewController {
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var username: UILabel!
    
    var setUsername = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = "Hello, " + setUsername + "!"
        
    }
    
    @IBAction func test(_ sender: UIButton) {
        Alamofire.request("http://mastermakrela.eu/bookchallenge/challenges/overview.txt").responseString { response in
            
            
            let html = response.description
            
            if let doc = HTML(html: html, encoding: .utf8){
                self.text.text = doc.content ?? "NULL"
            }
            
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

