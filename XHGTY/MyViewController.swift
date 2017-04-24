//
//  MyViewController.swift
//  +
//
//  Created by shensu on 17/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	var tabView: UITableView!
	var dataArray: Array<Array<String>>!
	var buttonBlock: (() -> ())?
	var tableViewClickBlock: ((_ index: Int) -> ())?
	var heard: UserView!
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		heard.reload()
		self.tabView.reloadData()
		let right = UIBarButtonItem(image: UIImage.init(named: "setting_normale"), style: .done, target: self, action: #selector(rightClick))
		right.tintColor = UIColor.white
		self.navigationItem.rightBarButtonItem = right
	}
	func rightClick() {
		let vc = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "FXSettingViewController")
		vc.hidesBottomBarWhenPushed = true;
		self.navigationController?.pushViewController(vc, animated: true)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
		let islogin = Apploction.default.isLogin ? "退出登录" : "请登录"
		dataArray = [["版本", "当前版本", "V \(version!)"], ["消息", "消息通知"], ["选号记录", "选号记录"], ["我的收藏", "我的收藏"], ["清理", "清理缓存"], ["退出", islogin]]

		self.view.backgroundColor = UIColor.white
		tabView = UITableView(frame: CGRect.zero, style: .grouped)
		tabView.delegate = self
		tabView.dataSource = self
		tabView.separatorStyle = .none
		tabView.showsVerticalScrollIndicator = false
		tabView.showsHorizontalScrollIndicator = false
		heard = UserView(frame: CGRect(x: 0, y: 0, width: tabView.frame.width, height: 200))
		heard.userinfoBlock = { [weak self] in

			if Apploction.default.isLogin {
				let vc = MyProfileViewController()
				vc.hidesBottomBarWhenPushed = true
				_ = self?.navigationController?.pushViewController(vc, animated: true)
			} else {
				let vc = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
				vc.hidesBottomBarWhenPushed = true
				_ = self?.navigationController?.pushViewController(vc, animated: true)
			}

		}
		heard.backgroundColor = UIColor.white
		tabView.tableHeaderView = heard

		let lable = UILabel()
		lable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)
		lable.text = "声明：本运用所有的活动均与苹果公司（Apple Inc.）无关"
		lable.textColor = UIColor.gray
		lable.font = UIFont.systemFont(ofSize: 12)
		lable.textAlignment = .center
		tabView.tableFooterView = lable
		self.view.addSubview(tabView)

		tabView <- [
			Top(),
			Bottom(),
			Left(),
			Right()
		]

		// Do any additional setup after loading the view.
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataArray.count
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellidentifi = "cell"
		var cell = tableView.dequeueReusableCell(withIdentifier: cellidentifi)
		if cell == nil {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellidentifi)
		}
		cell?.textLabel?.text = dataArray[indexPath.section][1]
		cell?.textLabel?.textColor = UIColor.gray
		cell?.backgroundColor = UIColor.white
		cell?.selectionStyle = .none
		cell?.imageView?.image = UIImage(named: dataArray[indexPath.section][0])
		if indexPath.section == 0 {
			let lable = UILabel()
			lable.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
			lable.font = UIFont.systemFont(ofSize: 14)
			lable.textColor = UIColor.gray
			lable.textAlignment = .right
			lable.text = dataArray[indexPath.section][2]
			cell?.accessoryView = lable
		}
		else {
			if indexPath.section == 5 {
				cell?.textLabel?.text = Apploction.default.isLogin ? "退出登录" : "请登录"
			}
			cell?.accessoryType = .disclosureIndicator
		}
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		self.tableViewClickBlock?(indexPath.row)
		if indexPath.section == 1 {
			if UIApplication.shared.canOpenURL(URL.init(string: "prefs:root=Phone")!) {
				UIApplication.shared.openURL(URL.init(string: "prefs:root=Phone")!)
			}

//            #define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
//
//            if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication] openURL:url];
//                }
//            } else {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"]];
//            }
//

			if let version: Float = Float(UIDevice.current.systemVersion), version > 8.0 {
				let url = URL(string: UIApplicationOpenSettingsURLString)
				if UIApplication.shared.canOpenURL(url!) {
					UIApplication.shared.openURL(url!)
				}
			} else {
				UIApplication.shared.openURL(URL.init(string: "prefs:root=Phone")!)
			}

		} else if indexPath.section == 2 {
			if Apploction.default.isLogin {
				let vc = MNXHTableViewController()
				vc.hidesBottomBarWhenPushed = true
				_ = self.navigationController?.pushViewController(vc, animated: true)

			} else {
				let vc = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
				vc.hidesBottomBarWhenPushed = true
				_ = self.navigationController?.pushViewController(vc, animated: true)
			}
		}
		else if indexPath.section == 3 {
			if Apploction.default.isLogin {
				let vc = TouzhuTableViewController()
				_ = self.navigationController?.pushViewController(vc, animated: true)
			} else {
				let vc = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
				vc.hidesBottomBarWhenPushed = true
				_ = self.navigationController?.pushViewController(vc, animated: true)
			}

		} else if indexPath.section == 4 {
			SDImageCache.shared().cleanDisk()
			SVProgressHUD.showSuccess(withStatus: "清理缓存成功")
			DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
				SVProgressHUD.dismiss()
			})
		} else if indexPath.section == 5 {
			let defa = UserDefaults.standard
			defa.removeObject(forKey: "account")
			defa.removeObject(forKey: "password")
			Apploction.default.isLogin = false
			let vc = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
			vc.hidesBottomBarWhenPushed = true
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}

	}
	func imageViewClick() {

	}

	func openAlbum() {
		// 判断设置是否支持图片库
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			// 初始化图片控制器
			let picker = UIImagePickerController()
			// 设置代理

			// 指定图片控制器类型
			picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
			// 设置是否允许编辑
			// picker.allowsEditing = editSwitch.on
			// 弹出控制器，显示界面
			self.present(picker, animated: true, completion: {
				() -> Void in
				picker.delegate = self
			})
		} else {
			print("读取相册错误")
		}
	}

	func openCamera() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {

			// 创建图片控制器
			let picker = UIImagePickerController()
			// 设置代理
			// 设置来源
			picker.sourceType = UIImagePickerControllerSourceType.camera
			// 允许编辑
			picker.allowsEditing = true
			// 打开相机
			self.present(picker, animated: true, completion: { () -> Void in
				picker.delegate = self

			})
		} else {
			debugPrint("找不到相机")
		}
	}

	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			heard.userImage.image = image
			Apploction.default.userImage = image
		}
		else {
		}
		picker.dismiss(animated: true, completion: nil)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
