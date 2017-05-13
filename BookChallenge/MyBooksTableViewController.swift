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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        books = [:]
        loadBooks(category: category)
    }
    
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        print("DISAPIR")
    //    }
    
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
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
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
