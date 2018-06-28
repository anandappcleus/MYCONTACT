//
//  MyContactCell.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 27/06/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

class MyContactCell: UITableViewCell {

    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
