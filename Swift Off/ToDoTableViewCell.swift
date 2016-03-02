//
//  ToDoTableViewCell.swift
//  Swift Off
//
//  Created by Ashkan Kashani on 2/24/16.
//  Copyright © 2016 Primer. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
