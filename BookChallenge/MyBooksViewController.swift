//
//  MyBooksViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 08.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit

class MyBooksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Use this method for any further categories
    @IBAction func selectCategory(_ sender: UIButton) {
        performSegue(withIdentifier: "BookCategorySegue", sender: sender.currentTitle!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? MyBooksTableViewController {
            nextVC.category = (sender as? String)!
        }
        
    }
    
    
}
