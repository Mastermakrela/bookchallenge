//
//  ChallengeTableViewCell.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 08.09.2016.
//  Copyright © 2016 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var challengeID: Int = -1
    @IBOutlet weak var challengeName: UILabel!
    @IBOutlet weak var challengeDone: UISwitch!
    
    @IBAction func doneValueChanged(_ sender: UISwitch) {
        let parametesrs: Parameters = [
            "challengeID" : challengeID,
            "done" : sender.isOn,
            "user_id" : userID,
        ]
        
        Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/challenges/updateState.php", method: .post, parameters: parametesrs).responseString { response in
//            print(response)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
