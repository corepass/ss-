//
//  NewTableViewController.swift
//  bjscpk10
//
//  Created by shensu on 17/3/23.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit

class NewTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	var modelArray: Array<Dictionary<String, Any>>!
	var page: Int = 0
	var tableView: UITableView!
	var segumented: UISegmentedControl!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "资讯预测"
		self.view.backgroundColor = UIColor.white

		modelArray = Array()
		segumented = UISegmentedControl(items: ["彩票", "篮球", "体育"])
		segumented.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
		segumented.addTarget(self, action: #selector(segumentedClick), for: .valueChanged)
		segumented.tintColor = UIColor.white
		segumented.selectedSegmentIndex = 0

		self.navigationItem.titleView = segumented

		tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .grouped)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.showsVerticalScrollIndicator = false
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()

		self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
			self.modelArray.removeAll()
			self.page = 0
			self.loadata()
		})
		self.view.addSubview(tableView)
		loadata()
	}

	func segumentedClick(sender: UISegmentedControl) {
		self.modelArray.removeAll()
		loadata()
	}
	func loadata() {
		SVProgressHUD.show()
		// http://mapi.159cai.com/discovery/news/football/index.json
		let url: URL!
		if segumented.selectedSegmentIndex == 1 {
			url = URL.init(string: "http://mapi.159cai.com/discovery/news/football/index.json")!
		} else if segumented.selectedSegmentIndex == 2 {
			url = URL.init(string: "http://mapi.159cai.com/discovery/news/basketball/index.json")
		} else {
			url = URL.init(string: "http://mapi.159cai.com/discovery/news/szc/index.json")
		}
		// http://mapi.159cai.com/discovery/news/szc/index.json
		let urlrequest = URLRequest.init(url: url!)
		let session = URLSession.shared
		let dataTask = session.dataTask(with: urlrequest) { (data, respont, error) in
			DispatchQueue.main.async {
				SVProgressHUD.dismiss()
				self.tableView.mj_header.endRefreshing()
			}
			if data != nil {
				if let array = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Array<Dictionary<String, Any>> {
					// let array = dic?["T1356600029035"]
					array?.enumerated().forEach({ (index, model) in
						if index > 0 && index < 11 {
							self.modelArray.append(model as! [String: String])
						}
					})

				}
				DispatchQueue.main.async {

					self.tableView.reloadData()
				}
			}

		}
		dataTask.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.01
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return self.modelArray.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("NewTableViewCell", owner: self, options: nil)?.last as? NewTableViewCell
		}
		if self.modelArray.count > indexPath.row {
			cell?.setModel(dic: self.modelArray[indexPath.row])
		}
		cell?.selectionStyle = .none
		return cell!
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = NewDataViewController()
		vc.title = "新闻详情"
		vc.hidesBottomBarWhenPushed = true
		vc.url = URL(string: self.modelArray[indexPath.row]["url"]! as! String)
		_ = self.navigationController?.pushViewController(vc, animated: true)
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
