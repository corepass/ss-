//
//  Apploction.swift
//  bjscpk10
//
//  Created by shensu on 17/3/24.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit

class Apploction: NSObject {
	public static var `default` = Apploction()
	var userdefa = UserDefaults.standard
	var isLogin: Bool {
		get {
			return userdefa.bool(forKey: "isLogin")
		}
		set {
			userdefa.set(newValue, forKey: "isLogin")
		}
	}

	var userImage: UIImage? {
		get {
			let data = userdefa.value(forKey: "userImage") as? Data
			if data == nil {
				return nil
			}

			return UIImage.init(data: data!, scale: 1)
		}
		set {
			let data = UIImageJPEGRepresentation(newValue!, 0.5)
			return userdefa.set(data, forKey: "userImage")
		}
	}

}

extension UIButton {

	@objc public enum ImageButtonType: UInt {
		case ImageButtonLeft = 0
		case ImageButtonTop = 1
		case ImageButtonBottom = 2
		case ImageButtonRight = 3
	}
	@objc public func imageButtonInsetsType(type: ImageButtonType, imagewithTitleSpace space: CGFloat) {
		let imageWidth = self.imageView?.intrinsicContentSize.width ?? 0
		let imageHeight = self.imageView?.intrinsicContentSize.height ?? 0
		let lableWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
		let lableHeight = self.titleLabel?.intrinsicContentSize.height ?? 0

		var imageInsets = UIEdgeInsets.zero
		var lableInsets = UIEdgeInsets.zero
		switch type {
		case .ImageButtonTop:
			imageInsets = UIEdgeInsets(top: -lableHeight - space / 2, left: 0, bottom: 0, right: -lableWidth)
			lableInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space / 2.0, right: 0)
		case .ImageButtonBottom:
			imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -lableHeight - space / 2, right: -lableWidth)
			lableInsets = UIEdgeInsets(top: -imageHeight - space / 2, left: -imageWidth, bottom: 0, right: 0)
		case .ImageButtonRight:
			imageInsets = UIEdgeInsets(top: 0, left: lableWidth + space / 2, bottom: 0, right: -lableWidth - space / 2)
			lableInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2, bottom: 0, right: imageWidth + space / 2)
		default:
			imageInsets = UIEdgeInsets(top: 0, left: -space / 2.0, bottom: 0, right: -space / 2)
			lableInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
			break

		}
		self.titleEdgeInsets = lableInsets
		self.imageEdgeInsets = imageInsets
	}
}
