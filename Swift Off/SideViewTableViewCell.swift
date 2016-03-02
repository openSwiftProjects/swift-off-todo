//
//  SideViewTableViewCell.swift
//  Swift Off
//
//  Created by Simon Jimmy Hsieh on 2/18/16.
//  Copyright © 2016 Primer. All rights reserved.
//

import UIKit

class SideViewTableViewCell: UITableViewCell {

    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
