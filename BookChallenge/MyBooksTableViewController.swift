//
//  MyBooksTableViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 06/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class MyBooksTableViewController: UITableViewController {
    
    var books: [String : Book] = [ : ]
    
    @IBOutlet weak var categoryTitle: UINavigationItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var category = "My Books"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.isEnabled = categories.contains(category) ? true : false
        
        categoryTitle.title = category
        loadBooks(category: category)
        
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if category == "Recommended"{
            let alert = UIAlertController(title: "Not implemented", message: "Will be avalible in the futre", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Go Back", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in self.goBack()}))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        books = [:]
        self.tableView.reloadData()
        loadBooks(category: category)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBooksCell", for: indexPath) as! MyBooksTableViewCell
        
        let book = Array(books.values)[indexPath.row]
        
        cell.bookTitle.text = book.title
        cell.bookAuthor.text = book.author
        
        return cell
    }
    
    
    // MARK: - Get data from MySQL Server
    func loadBooks(category: String){
        let url = "http://mastermakrela.eu/bookchallenge/ios/myBooks/getBooks.php?user_id=" + String(userID) + "&status=" + (categoryNumber[category] ?? "-1")
        
        Alamofire.request(url).responseSwiftyJSON { response in
            
            switch response.result {
            case .success(let value):
                if let books = value.dictionary?["books"]?.array {
                    for book in books {
                        let bookDictionary = book.dictionary!
                        let key = (bookDictionary["title"]?.stringValue)! + (bookDictionary["author"]?.stringValue)!
                        self.books[key] = Book(title: (bookDictionary["title"]?.stringValue)!, author: (bookDictionary["author"]?.stringValue)!, id: (bookDictionary["id"]?.stringValue)!, startDate: (bookDictionary["start"]?.stringValue)!, endDate: (bookDictionary["end"]?.stringValue)!, status: (bookDictionary["status"]?.stringValue)!)!
                    }
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch(sender){
        case is UIBarButtonItem:
            if let nextVC = segue.destination as? AddBookViewController {
                nextVC.category = category
            }
            
        case is MyBooksTableViewCell:
            let key = (sender as! MyBooksTableViewCell).bookTitle.text! + (sender as! MyBooksTableViewCell).bookAuthor.text!
            let book = books[key]!
            
            if let nextVC = segue.destination as? SelectedBookViewController {
                nextVC.book = book
            }
            
        default:
            print("ERROR")
        }
        
        
    }
    
    
}
