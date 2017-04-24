//
//  MNXHTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class MNXHTableViewCell: UITableViewCell {

	@IBOutlet weak var sumnumber: UILabel!
	@IBOutlet weak var cpnumber: UILabel!
	@IBOutlet weak var qishu: UILabel!
	@IBOutlet weak var typeName: UILabel!
	@IBOutlet weak var iconImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func setModel(model: Dictionary<String, String>) {
		sumnumber.text = "共\(model["sumMoney"] ?? "")注"
		cpnumber.text = "\(model["number"] ?? "")"
		qishu.text = "第\(model["qishu"] ?? "")期"
		typeName.text = "\(model["name"] ?? "")"
		iconImage.image = UIImage(named: model["name"] ?? "")
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
