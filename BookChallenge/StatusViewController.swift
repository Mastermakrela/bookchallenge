//
//  StatusViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 08.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON

class StatusViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var booksRead: UILabel!
    @IBOutlet weak var challengesCompleted: UILabel!
    
    @IBOutlet weak var booksStackView: UIStackView!
    @IBOutlet weak var toReadLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var finishedLabel: UILabel!
    
    @IBOutlet weak var bioButton: UIButton!
    
    var setUsername = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userID == 7 {
            bioButton.isHidden = false
        }
        
        let booksTap = UITapGestureRecognizer(target: self, action: #selector(StatusViewController.booksTap))
        booksRead.addGestureRecognizer(booksTap)
        
        username.text = "Hello, " + setUsername.localizedCapitalized + "!"
        
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        
        let url = "http://mastermakrela.eu/bookchallenge/ios/homeScreen/status.php?user_id=" + String(userID)
        Alamofire.request(url).responseSwiftyJSON { response in
            switch response.result {
            case .success(let value):
                let results = value.array?[0].dictionary!
                
                self.challengesCompleted.text = "You have already completed " + (results?["challenges"]?.stringValue)! + " challenges"
                let sum = (results?["toRead"]?.intValue)! + (results?["started"]?.intValue)! + (results?["finished"]?.intValue)!
                self.booksRead.text = "You have read " + String(sum) + " books"
                self.toReadLabel.text = (results?["toRead"]?.stringValue)! + " Still waiting to be read."
                self.startedLabel.text = (results?["started"]?.stringValue)! + " Started but not finished."
                self.finishedLabel.text = (results?["finished"]?.stringValue)! + " Sompleted."
                
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func booksTap() {
        booksStackView.isHidden = !booksStackView.isHidden
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

