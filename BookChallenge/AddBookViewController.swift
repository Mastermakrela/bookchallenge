//
//  AddBookViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 12/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire

class AddBookViewController: UIViewController {
    
    var category: String = "none"
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var startDateStackView: UIStackView!
    @IBOutlet weak var endDateStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch category {
        case "To Read":
            startDateStackView.isHidden = true
            endDateStackView.isHidden = true
            break
        case "Started":
            endDateStackView.isHidden = true
            break
        default: break
        }
    }
    
    
    @IBAction func addBook(_ sender: UIBarButtonItem) {
        
        var parameters: Parameters = [
            "user_id" : userID,
            "status" : categoryNumber[category]!,
            "title" : titleField.text!,
            "author" : authorField.text!,
            "startDate" : "",
            "endDate" : "",
            ]
        
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        
        switch category {
        case "Started":
            parameters["startDate"] = date.string(from: startDatePicker.date)
            break
        case "Finished":
            parameters["startDate"] = date.string(from: startDatePicker.date)
            parameters["endDate"] = date.string(from: endDatePicker.date)
            break
        default: break
        }
        
        
        Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/myBooks/addBook.php", method: .post, parameters: parameters).responseString { response in
            switch response.result{
            case .success :
                self.navigationController?.popViewController(animated: true)
                break
            case .failure :
                break
            }
        }
        
    }
    
    
    // Return key moves to next field
    // Adapted from: http://stackoverflow.com/a/31766986
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }*/
    
    
}
