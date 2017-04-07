//
//  TouzhuTableViewCell.swift
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class TouzhuTableViewCell: UITableViewCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qishu: UILabel!
    @IBOutlet weak var type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
