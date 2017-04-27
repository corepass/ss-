//
//  KJTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class KJTableViewCell: UITableViewCell {

    @IBOutlet weak var kjSub: UILabel!
    @IBOutlet weak var kjImage: UIImageView!
    @IBOutlet weak var kjType: UILabel!
	@IBOutlet weak var backView: UIView!
	@IBOutlet weak var openTime: UILabel!
	@IBOutlet weak var qishu: UILabel!
	@IBOutlet weak var cpType: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		self.accessoryType = .disclosureIndicator

	}
	func setModel(model: KJModel) {
		qishu.alpha = 0
		qishu.text = "\(model.qiShu)"
		kjType.text = model.name
        kjImage.image = UIImage(named: model.name)
//		let array = model.openNumber.components(separatedBy: ",")
//		var sumArray = Array<Any>()
//		for string in array {
//			let clArray = string.components(separatedBy: ":");
//			for array in clArray {
//				sumArray.append(array)
//			}
//
//		}
//
//		for i in 0..<sumArray.count {
//
//			let lable = UILabel()
//
//			if CGFloat(30 * sumArray.count) > self.contentView.frame.width {
//				lable.frame = CGRect(x: 20 * i, y: 5, width: 15, height: 25)
//
////				lable.layer.cornerRadius = 12.5
//				if i == array.count - 1 {
//					lable.backgroundColor = UIColor.init(red: 27.0 / 255.0, green: 236 / 255.0, blue: 224 / 255.0, alpha: 1)
//				} else {
//					lable.backgroundColor = UIColor.init(red: 237 / 255.0, green: 31 / 255.0, blue: 65 / 255.0, alpha: 1)
//				}
//
//			} else {
//				lable.frame = CGRect(x: 30 * i, y: 5, width: 25, height: 25)
//
//				lable.layer.cornerRadius = 12.5
//				if i == array.count - 1 {
//					lable.backgroundColor = UIColor.init(red: 27.0 / 255.0, green: 236 / 255.0, blue: 224 / 255.0, alpha: 1)
//				} else {
//					lable.backgroundColor = UIColor.init(red: 237 / 255.0, green: 31 / 255.0, blue: 65 / 255.0, alpha: 1)
//				}
//
//			}
//
//			lable.layer.masksToBounds = true
//			lable.text = "\(sumArray[i])"
//			lable.textAlignment = .center
//			lable.textColor = UIColor.white
//			lable.font = UIFont.systemFont(ofSize: 14)
//
//			backView.addSubview(lable)
//		}

	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
