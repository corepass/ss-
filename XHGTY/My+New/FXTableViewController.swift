//
//  FXTableViewController.swift
//  +
//
//  Created by shensu on 17/4/5.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class FXTableViewController: UITableViewController {
	var dataarray: Array<Array<Dictionary<String, String>>> = [[["image": "彩票专区", "title": "开奖记录", "sub": "双色球 奖池 6亿5647亿"]], [["image": "彩票资讯", "title": "新闻资讯", "sub": "临场推荐，狠狠提高命中率"]], [["image": "投注站", "title": "投注站", "sub": "随时获取你身边的彩票店", "url": "http://live.159cai.com/live/jingcai?from=159cai"], ["image": "体育比分", "title": "体育赛事", "sub": "比分直播，第一手赛况全掌握", "url": "http://mlive.159cai.com/live/basketball?from=159cai"]], [["image": "分析", "title": "赛事分析", "sub": "赛事情况专家分析"]], [["image": "特别号分析", "title": "特别号分析", "sub": "为您获取精准号码"]]]
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
		let right = UIBarButtonItem.init(title: "论坛", style: .done, target: self, action: #selector(rightClick))
		right.tintColor = UIColor.white
		self.navigationItem.rightBarButtonItem = right
	}
	func rightClick() {
		let vc = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "ForumViewController")
		vc.hidesBottomBarWhenPushed = true
		_ = self.navigationController?.pushViewController(vc, animated: true)
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return dataarray.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return dataarray[section].count
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FXTableViewCell

		if cell == nil {
			cell = Bundle.main.loadNibNamed("FXTableViewCell", owner: self, options: nil)?.first as? FXTableViewCell
		}
		let model = dataarray[indexPath.section][indexPath.row]
		cell?.setModel(model: model)
		cell?.selectionStyle = .none
		cell?.accessoryType = .disclosureIndicator

		return cell!
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			let vc = KJTableViewController()
			vc.hidesBottomBarWhenPushed = true
			_ = self.navigationController?.pushViewController(vc, animated: true)
		case 1:
			let vc = FXWebViewController()
			vc.hidesBottomBarWhenPushed = true
			vc.isneed = true
			vc.accessUrl = "http://news.soa.woying.com/"
			vc.titleName = "彩票资讯";
			vc.hidesBottomBarWhenPushed = false;
			_ = self.navigationController?.pushViewController(vc, animated: true)

		case 2:
			if indexPath.row == 0 {
				let cp = CpMapViewController()
				cp.hidesBottomBarWhenPushed = true
				_ = self.navigationController?.pushViewController(cp, animated: true)
			} else {
				let vc = TYBFViewController()
				vc.hidesBottomBarWhenPushed = true
				_ = self.navigationController?.pushViewController(vc, animated: true)
			}

		case 3:
			let vc = FXHomeTableViewController()
			vc.hidesBottomBarWhenPushed = true
			_ = self.navigationController?.pushViewController(vc, animated: true)

		default:
            let vc = TieBieViewController()
            vc.hidesBottomBarWhenPushed = true
            _ = self.navigationController?.pushViewController(vc, animated: true)
            
			break
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
