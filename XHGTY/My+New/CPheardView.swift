//
//  CPheardView.swift
//  +
//
//  Created by shensu on 17/4/25.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class CPheardView: UIView {
	var zstBtnClickBlock: (() -> ())?
	var lableArray: [UILabel] = Array()
	@IBOutlet weak var numberView: UIView!
	@IBOutlet weak var detaLable: UILabel!
	@IBOutlet weak var qishu: UILabel!
	@IBOutlet weak var kaijian: UILabel!
	override init(frame: CGRect) {
		super.init(frame: frame)
		let contentView = loadViewFromNib()
		addSubview(contentView)
		contentView <- [

			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		let timer: Timer?
		if #available(iOS 10.0, *) {
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
				self.timeMeth()
			}
		} else {
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeMeth), userInfo: nil, repeats: true)
		}
		RunLoop.current.add(timer!, forMode: .commonModes)
		zstBtn.layer.cornerRadius = 4
        zstBtn.backgroundColor = qishu.textColor

	}
	@IBOutlet weak var zstBtn: UIButton!
	@IBAction func zstButton(_ sender: Any) {
		self.zstBtnClickBlock?()
	}
	func timeMeth() {
		if kaijian.text == "开奖中." {
			kaijian.text = "开奖中.."
		} else if kaijian.text == "开奖中.." {
			kaijian.text = "开奖中..."
		} else if kaijian.text == "开奖中..." {
			kaijian.text = "开奖中...."
		} else {
			kaijian.text = "开奖中."
		}
	}

	// 初始化时将xib中的view添加进来
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		let contentView = loadViewFromNib()
		addSubview(contentView)

		// 初始化属性配置

	}
	override func layoutSubviews() {

	}
	// 加载xib
	func loadViewFromNib() -> UIView {
		let className = type(of: self)
		let bundle = Bundle(for: className)
		let name = NSStringFromClass(className).components(separatedBy: ".").last
		let nib = UINib(nibName: name!, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
		return view
	}
	func setModel(dic: Dictionary<String, Any>?) {

		let number = Int(dic?["expect"] as? String ?? "")! + 1
		qishu.text = "\(number)"
		detaLable.text = "第\(dic?["expect"] as? String ?? "")期  开奖时间：\(dic?["opentime"] as? String ?? "")"
		let array = (dic?["opencode"] as? String ?? "").components(separatedBy: ",")
		let width = self.numberView.frame.width / CGFloat(array.count)
		let space = (width - 30) / 2

		for i in 0..<array.count {
			let lable = UILabel()
			lable.font = UIFont.systemFont(ofSize: 12)
			lable.layer.cornerRadius = 15
			lable.backgroundColor = qishu.textColor
            lable.layer.masksToBounds = true
			lable.textColor = UIColor.white

			if array.count > i {
				lable.text = array[i]
			}
			lable.textAlignment = .center
			self.numberView.addSubview(lable)
			lableArray.append(lable)
			let is0 = i == 0 ? true : false
			lable <- [
				Left(space).to(numberView, .left).when { is0 },
				CenterY().to(numberView),
				Size(CGSize(width: 30, height: 30))
			]
			if i != 0 {
				lable <- [

					Left(space * 2).to(lableArray[i - 1], .right).when { !is0 },

				]

			}

		}

	}

	/*
	 // Only override draw() if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func draw(_ rect: CGRect) {
	 // Drawing code
	 }
	 */

}
