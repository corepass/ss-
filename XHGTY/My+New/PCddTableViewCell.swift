//
//  PCddTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/1.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class PCddTableViewCell: UITableViewCell {

    @IBOutlet weak var jieguo: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var qishu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
