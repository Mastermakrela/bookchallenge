//
//  ChallengeTableViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 17.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class ChallengeTableViewController: UITableViewController {
    
    // MARK: Properties
    var challenges = [Challenge]()
    @IBOutlet weak var challengesTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        
        // Load samples
        //        loadSamples()
        challengesTitle.title = "Year 2017"
        
        loadChallenges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        challenges = []
        loadChallenges()
    }
    
    func loadChallenges(){
        
        let url = "http://mastermakrela.eu/bookchallenge/ios/challenges/getChallenges.php?user_id=" + String(userID)
        
        Alamofire.request(url).responseSwiftyJSON { response in
            switch response.result{
            case .success(let value):
                if let weeks = value.dictionary?["challenges"]?.array {
                    for week in weeks {
                        let challengeDictionary = week.dictionary!
                        self.challenges += [Challenge(id: (challengeDictionary["id"]?.intValue)!, name: (challengeDictionary["name"]?.stringValue)!, done: (challengeDictionary["done"]?.boolValue)!)!]
                    }
                }
                self.tableView.reloadData()
            case .failure(let error):
                print("FAIL")
                print(error)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeTableVievCell", for: indexPath) as! ChallengeTableViewCell
        
        // Fetches the approprieate challenge for the data source layout.
        let challenge = challenges[indexPath.row]
        
        // DEBUG
        cell.challengeName.text = String(challenge.id) + " " + challenge.name
//        cell.challengeName.text = challenge.name
        cell.challengeDone.isOn = challenge.done
        cell.challengeID = challenge.id
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
