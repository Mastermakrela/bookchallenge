//
//  MyBooksTableViewCell.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 06/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit

class MyBooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
