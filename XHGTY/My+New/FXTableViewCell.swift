//
//  FXTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/5.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class FXTableViewCell: UITableViewCell {
	func setModel(model: Dictionary<String, String>) {
		title.text = model["title"]
		subTitle.text = model["sub"]
		titleImage.image = UIImage(named: model["image"]!)
		if model["title"] == "开奖记录" {
			titleImage.image = UIImage(named: "彩票论坛")
		}

	}
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var subTitle: UILabel!
	@IBOutlet weak var titleImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
