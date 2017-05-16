//
//  CreatorsBioViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 13/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class CreatorsBioViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/homeScreen/bio.html").responseString(encoding: .utf8) { response in
            switch response.result {
            case .success(let value):
                
                
                if let doc = HTML(html: value, encoding: String.Encoding.utf8) {
                    
                    // Search for nodes by CSS
                    for link in doc.css("html") {
                        self.textView.text = link.text!

                    }
                    
                }
                
                
                break
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
