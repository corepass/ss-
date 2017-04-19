//
//  TouzhuTableViewController.swift
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class TouzhuTableViewController: UITableViewController {
	var dataArray: Array<Dictionary<String, Any>>?
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "我的收藏";
		let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
				.userDomainMask, true).first!
		let userAccountPath = "\(path)/Caches/userAccount.shouchang"
		if NSArray(contentsOfFile: userAccountPath) != nil {
			dataArray = NSArray(contentsOfFile: userAccountPath) as? Array<Dictionary<String, Any>>
		} else {

			SVProgressHUD.show(withStatus: "暂无收藏数据")
			DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
				SVProgressHUD.dismiss()
			})

		}

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return (dataArray != nil)
			? dataArray!.count : 0
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellidentifi = "cell"
		var cell = tableView.dequeueReusableCell(withIdentifier: cellidentifi) as? TouzhuTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("TouzhuTableViewCell", owner: self, options: nil)?.first as! TouzhuTableViewCell?
		}
		if (dataArray?.count)! > indexPath.row {
			cell?.type.text = "收藏时间\(dataArray?[indexPath.row]["time"] ?? "")"
			cell?.price.text = "第\(dataArray?[indexPath.row]["qishu"] ?? "")期"
			cell?.state.text = dataArray?[indexPath.row]["kjtime"]! as? String
			cell?.setData(array: dataArray?[indexPath.row]["haoma"]! as! Array<String>)
		}
		// Configure the cell...

		return cell!
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		_ = self.navigationController?.popToRootViewController(animated: false)
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
