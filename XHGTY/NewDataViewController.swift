//
//  NewDataViewController.swift
//  bjscpk10
//
//  Created by shensu on 17/3/23.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit
import WebKit
class NewDataViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
	var webview: WKWebView!
	var url: URL!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

	}
	func goback() {

		_ = self.navigationController?.popViewController(animated: true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		webview = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
		webview.scrollView.delegate = self
		webview.isUserInteractionEnabled = true
		webview.navigationDelegate = self
		webview.load(URLRequest.init(url: self.url))
		self.view.addSubview(webview)
		SVProgressHUD.show()
		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		SVProgressHUD.dismiss()
	}
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		SVProgressHUD.dismiss()
		webview.load(URLRequest.init(url: webview.url!))
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
