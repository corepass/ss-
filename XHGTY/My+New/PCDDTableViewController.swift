//
//  PCDDTableViewController.swift
//  +
//
//  Created by shensu on 17/4/1.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class PCDDTableViewController: UITableViewController {
	var segumented: UISegmentedControl!
	var url = "http://api.dabai28.com/api28.php?name=pc28&type=json"
	var modelArray = Array<Dictionary<String, String>>()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "PC蛋蛋"

		loaddata()
		self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
			self.loaddata()

		})

		let right = UIBarButtonItem(title: "选号", style: .done, target: self, action: #selector(btnClick))
		right.tintColor = UIColor.white
		self.navigationItem.rightBarButtonItem = right

	}
	func btnClick() {
		let vc = GoucaiViewController()
		vc.hidesBottomBarWhenPushed = true
		_ = self.navigationController?.pushViewController(vc, animated: true)
	}
	func loaddata() {
		HttpTools.getCustonWithPath(self.url, parms: nil, success: { (resport) in
			if (resport != nil) {
				self.modelArray.removeAll()
				self.modelArray = resport as! Array<Dictionary<String, String>>
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
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
        	btnClick()
        }
	}
	func segumentedClick(sender: UISegmentedControl) {
		self.modelArray.removeAll()
		if sender.selectedSegmentIndex == 0 {
			self.url = "http://api.dabai28.com/api28.php?name=pc28&type=json"
		} else {
			self.url = "http://api.dabai28.com/api28.php?name=jnd28&type=json"
		}

		loaddata()
		self.tableView.reloadData()
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
				cell?.qishu.text = "第\(model["issue"]!)期"
				let str = "\(model["time"]!)"
				let index = str.index(str.startIndex, offsetBy: 5)
				let suffix = str.substring(from: index)
				cell?.time.text = suffix
				let one = Int(model["one"]!)
				let two = Int(model["two"]!)
				let three = Int(model["three"]!)
				cell?.jieguo.text = "\(one!)+\(two!)+\(three!)=\(one! + two! + three!)"
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

	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */

	/*
	 // Override to support editing the table view.
	 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	 if editingStyle == .delete {
	 // Delete the row from the data source
	 tableView.deleteRows(at: [indexPath], with: .fade)
	 } else if editingStyle == .insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */

	/*
	 // Override to support rearranging the table view.
	 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	 }
	 */

	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
