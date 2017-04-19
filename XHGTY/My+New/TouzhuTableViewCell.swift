//
//  TouzhuTableViewCell.swift
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit
class TouzhuTableViewCell: UITableViewCell {
	var lableArray: [UILabel] = Array()
	@IBOutlet weak var state: UILabel!
	@IBOutlet weak var price: UILabel!
	@IBOutlet weak var qishu: UILabel!
	@IBOutlet weak var type: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
//        for (int i = 0;i < 7 ; i++) {
//            UILabel * lable = [[UILabel alloc]init];
//            lable.text = nArray[i];
//            lable.layer.cornerRadius = 15;
//            [lable setTextAlignment:NSTextAlignmentCenter];
//            lable.layer.borderWidth = 1;
//            if (i == 6){
//                lable.layer.borderColor = [[UIColor alloc] initWithRed:20/255.0 green:114/255.0 blue:214/255.0 alpha:1].CGColor;
//            }else{
//                lable.layer.borderColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1].CGColor;
//            }
//
//            lable.font = [UIFont systemFontOfSize:12];
//            [self addSubview:lable];
//            [lableArray addObject:lable];
//            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
//                if(i == 0){
//                make.left.mas_equalTo(self).offset(15);
//                }else{
//                UILabel * lable = lableArray[i-1];
//                make.left.mas_equalTo(lable.mas_right).offset(5);
//                }
//                make.top.mas_equalTo(self.typeLable.mas_bottom).offset(5);
//                make.bottom.mas_equalTo(self).offset(-5);
//                make.size.mas_offset(CGSizeMake(30, 30));
//                }];
//
//        }

		for i in 0..<7 {
			let lable = UILabel()
			lable.font = UIFont.systemFont(ofSize: 12)
			lable.layer.cornerRadius = 15
			lable.layer.borderWidth = 1
			if i == 6 {
				lable.layer.borderColor = UIColor(red: 20 / 255.0, green: 114 / 255.0, blue: 214 / 255.0, alpha: 1).cgColor
			} else {
				lable.layer.borderColor = UIColor(red: 237 / 255.0, green: 31 / 255.0, blue: 65 / 255.0, alpha: 1).cgColor
			}
			lable.textAlignment = .center
			self.contentView.addSubview(lable)
			lableArray.append(lable)
			let is0 = i == 0 ? true : false
			lable <- [
				Left(15).to(self.contentView, .left).when { is0 },

				Top(7).to(type, .bottom),
				Bottom(7).to(self.contentView, .bottom),
				Size(CGSize(width: 30, height: 30))
			]
			if i != 0 {
				lable <- [

					Left(5).to(lableArray[i - 1], .right).when { !is0 },

				]

			}

		}
	}
	func setData(array: Array<String>) {
		for i in 0..<array.count {
			let lable = lableArray[i]
			lable.text = array[i]
		}
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
