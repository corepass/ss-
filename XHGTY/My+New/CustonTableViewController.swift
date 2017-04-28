//
//  CustonTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/5.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class CustonTableViewController: UITableViewController {
	var segumented: UISegmentedControl!
	var url = ""
	var modelArray = Array<Dictionary<String, Any>>()
	override func viewDidLoad() {
		super.viewDidLoad()
		loaddata()
		self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
			self.loaddata()
		})

		let right = UIBarButtonItem(title: "选号", style: .done, target: self, action: #selector(btnClick))
		right.tintColor = UIColor.white
		self.navigationItem.rightBarButtonItem = right

	}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            btnClick()
        }
    }
	func btnClick() {
		var dic = Dictionary<String, Any>()
		let vc = MNXHViewController()

		if self.title == "重庆时时彩" {
			dic = ["dataArray": [["number": "9", "count": "1"], ["number": "9", "count": "1"], ["number": "9", "count": "1"]], "nBlue": "0", "type": "pc"]
		} else if self.title == "北京PK10" || self.title == "天津时时彩" || self.title == "新疆时时彩" {

			dic = ["dataArray": [["number": "9", "count": "1"], ["number": "9", "count": "1"], ["number": "9", "count": "1"], ["number": "9", "count": "1"], ["number": "9", "count": "1"]], "nBlue": "4", "type": "pc", "rule": "任选5个号码，选中号与开奖开奖号码一致即中奖"]
		} else if self.title == "香港六合彩" {
			dic = ["dataArray": [["number": "49", "count": "1"]], "nBlue": "0", "type": "pc", "rule": "任选1个号码，选中号与开奖开奖号码一致即中奖"];
		} else if self.title == "江苏快3" {
			dic = ["dataArray": [["number": "18", "count": "1"]], "nBlue": "0", "type": "pc", "rule": "任选1个号码，选中号与开奖开奖号码最后一位一致即中奖"]
		} else if self.title == "广东11选5" || self.title == "山东11选5" || self.title == "江西11选5" {
			dic = ["dataArray": [["number": "11", "count": "1"], ["number": "11", "count": "1"], ["number": "11", "count": "1"]], "nBlue": "0", "type": "pc", "rule": "至少选2个号码，选中号与开奖任意2位一致即中奖"]
		} else if self.title == "广东快乐10" || self.title == "天津快乐10" {
			dic = ["dataArray": [["number": "21", "count": "1"]], "nBlue": "0", "type": "pc", "rule": "任选1个号码，选中号与开奖开奖号码最后一位一致即中奖"]
		}

		vc.hidesBottomBarWhenPushed = true;
		vc.title = self.title;
		vc.dataDic = dic;
		vc.url = self.url as NSString!;
		_ = self.navigationController?.pushViewController(vc, animated: true)

	}

	func loaddata() {

		HttpTools.postCustonCAIPIAO(withPath: self.url, parms: nil, success: { (resport) in
			if let data = resport as? Array<Dictionary<String, Any>> {
				self.modelArray.removeAll()
				self.modelArray = data
				DispatchQueue.main.async {
					self.tableView.reloadData()
					self.tableView.mj_header.endRefreshing()
				}
			}
		}) { (error) in
			SVProgressHUD.showError(withStatus: "数据加载出错，请稍候再试")
			DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
				SVProgressHUD.dismiss()
			})
		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return self.modelArray.count + 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 1
	}
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 5
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

		// Configure the cell...
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PCddTableViewCell
		cell = Bundle.main.loadNibNamed("PCddTableViewCell", owner: self, options: nil)?.first as! PCddTableViewCell?

		if indexPath.section == 0 {
			cell?.qishu.text = "期数"
			cell?.time.text = "开奖时间"
			cell?.jieguo.text = "开奖结果"
		} else {
			if modelArray.count > indexPath.section - 1 {
				let model = modelArray[indexPath.section - 1]
				cell?.qishu.text = "第\(model["expect"]!)期"
				let str = "\(model["opentime"]!)"
				let index = str.index(str.startIndex, offsetBy: 5)
				let suffix = str.substring(from: index)
				cell?.time.text = suffix
				cell?.jieguo.text = model["opencode"]! as? String
				cell?.qishu.backgroundColor = UIColor.init(red: 245.0 / 255.0, green: 225.0 / 255.0, blue: 210.0 / 255.0, alpha: 1)
				cell?.time.backgroundColor = UIColor.init(red: 245.0 / 255.0, green: 225.0 / 255.0, blue: 210.0 / 255.0, alpha: 1)
				cell?.jieguo.backgroundColor = UIColor.init(red: 245.0 / 255.0, green: 225.0 / 255.0, blue: 210.0 / 255.0, alpha: 1)
				cell?.jieguo.textColor = UIColor.gray
				cell?.time.textColor = UIColor.gray
				cell?.qishu.textColor = UIColor.gray
			}
		}
		cell?.selectionStyle = .none

		return cell!
	}

}
