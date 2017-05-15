//
//  SelectedBookViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 06/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire

class SelectedBookViewController: UIViewController {
    
    var book = Book(title: "", author: "", id: "", startDate: "", endDate: "", status: "")!
    
    
    @IBOutlet weak var selectedBookTitle: UINavigationItem!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    @IBOutlet weak var datePickerTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var moveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        
        
        
    }
    
    func loadInfo(){
        selectedBookTitle.title = book.title
        bookTitle.text = book.title
        bookAuthor.text = book.author
        timeSpent.text = String(describing: book.timeSpent) + " days"
        startDate.text = (book.startDate == "0000-00-00") ? "Not Started, yet" : book.startDate
        endDate.text = (book.endDate == "0000-00-00") ? "Not Finished, yet" : book.endDate
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        actionStackView.isHidden = !actionStackView.isHidden
        moveButton.isHidden = (book.status == "2")
        datePicker.isHidden = (book.status == "2")
        datePickerTitle.isHidden = (book.status == "2")
        
        switch book.status {
        case "0":
            datePickerTitle.text = "Select start date:"
        case "1":
            datePickerTitle.text = "Select end date:"
        default: break
        }
    }
    
    @IBAction func moveBook(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var parameters: Parameters = [
            "user_id" : userID,
            "title" : book.title,
            "book_id" : String(book.id)!,
            "status" : (Int(book.status)!+1),
            ]
        
        
        switch book.status {
        case "0":
            parameters["start_date"] = dateFormatter.string(from: datePicker.date)
            Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/mybooks/moveToStarted.php", method: .post, parameters: parameters).responseString { response in
                switch response.result {
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure:
                    break
                }
            }
        case "1":
            parameters["end_date"] = dateFormatter.string(from: datePicker.date)
            Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/mybooks/moveToFinished.php", method: .post, parameters: parameters).responseString { response in
                switch response.result {
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure:
                    break
                }
            }
        default: break
        }
        
    }
    
    
    @IBAction func deleteBook(_ sender: UIButton) {
        
        let parameters: Parameters = [
            "user_id" : userID,
            "title" : book.title,
            "book_id" : String(book.id)!
        ]
        
        Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/mybooks/deleteBook.php", method: .post, parameters: parameters).responseString { response in
            switch response.result {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure:
                break
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if let nextVC = segue.destination as? MyBooksViewController {
     nextVC.viewDidAppear(true)
     }
     
     }*/
    
    
}
