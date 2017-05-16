//
//  KJTableViewController.swift
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class KJTableViewController: UITableViewController {
	var dataArray = Array<Any>()
	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0.01))
		self.tableView.showsVerticalScrollIndicator = false

		getData()
		self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
			self.getData()
		})
        let right = UIBarButtonItem(title: "开奖推送", style: .done, target: self, action: #selector(kjpush))
        right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = right
	}
    
    func kjpush(){
    let vc = KJpushTableViewController()
    vc.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(vc, animated: true)
    
    }
	func getData() {
		HttpTools.get(withPath: "http://m.zhuoyicp.com/kaijang/kjhall?getData=1", parms: nil, success: { [weak self](data) in
			self?.tableView.mj_header.endRefreshing()

		}) { (error) in
			SVProgressHUD.showError(withStatus: "网络出错，请稍后再试")
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
				SVProgressHUD.dismiss()
			})
			self.tableView.mj_header.endRefreshing()
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
			let pathdic = NSDictionary.init(contentsOfFile: path!)
			self.dataArray = NSArray(array: KJModel.mj_objectArray(withKeyValuesArray: pathdic?["data"])) as! Array<Any>
			self.tableView.reloadData()
			SVProgressHUD.dismiss()
		}

	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 1
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return dataArray.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellidentifi = "cell"
		var cell = tableView.dequeueReusableCell(withIdentifier: cellidentifi) as? KJTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("KJTableViewCell", owner: self, options: nil)?.last as! KJTableViewCell?
		}
		if dataArray.count > indexPath.section {
			cell?.setModel(model: dataArray[indexPath.section] as! KJModel)
		}
		return cell!
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model: KJModel = dataArray[indexPath.section] as! KJModel
		if indexPath.section == 0 {
			let vc = PCDDTableViewController()
			vc.hidesBottomBarWhenPushed = true
			_ = self.navigationController?.pushViewController(vc, animated: true)
		} else {
			let vc = CustonTableViewController()
			vc.hidesBottomBarWhenPushed = true
			vc.url = model.url
			vc.title = model.name
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}
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
