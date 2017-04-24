//
//  MNXHTableViewController.swift
//  +
//
//  Created by shensu on 17/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class MNXHTableViewController: UITableViewController {
	var dataArray = Array<Dictionary<String, String>> ()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "选号记录"
		self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0.01))
        self.tableView.showsVerticalScrollIndicator = false
		let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
				.userDomainMask, true).first!
		let userAccountPath = "\(path)/Caches/caipiao.data"
		if NSArray(contentsOfFile: userAccountPath) != nil {
			if let array = NSArray(contentsOfFile: userAccountPath) as? Array<Dictionary<String, String>> {
				dataArray = array
			}
		} else {

			SVProgressHUD.show(withStatus: "暂无收藏数据")
			DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
				SVProgressHUD.dismiss()
			})

		}
        let right = UIBarButtonItem(title: "投注站", style: .done, target: self, action: #selector(rightClick))
        right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = right
    }
    func rightClick() {
        let vc = CpMapViewController()
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true)
    }
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return dataArray.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 1
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 54
	}
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 5;
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: MNXHTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as? MNXHTableViewCell
		if cell == nil {

			cell = Bundle.main.loadNibNamed("MNXHTableViewCell", owner: self, options: nil)?.first as? MNXHTableViewCell
		}
		if dataArray.count > indexPath.section {

			cell?.setModel(model: dataArray[indexPath.section])

		}

		// Configure the cell...

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
