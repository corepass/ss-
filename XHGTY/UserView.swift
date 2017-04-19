//
//  UserView.swift
//  bjscpk10
//
//  Created by shensu on 17/3/24.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit

class UserView: UIView {
    var userImage: UIImageView!
    var account: UILabel!
    var nickName: UILabel!
    var dataButton:UIButton!
    var backImage: UIImageView!
    var userinfoBlock: (()->())?
    override init(frame:CGRect){
    super.init(frame: frame)
        backImage = UIImageView()
        backImage.image =  UIImage.init(named: "backImage")
        self.addSubview(backImage)
        
        userImage = UIImageView()
        userImage.backgroundColor = UIColor.white
        if Apploction.default.userImage == nil {
            userImage.image = UIImage.init(named: "b94d5e6bf8da0c8f03d93d660d27d59b")
        }else{
        userImage.image = Apploction.default.userImage
        }
      //
        userImage.layer.cornerRadius = 30
        userImage.layer.masksToBounds = true
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self , action: #selector(userInfo))
        userImage.addGestureRecognizer(tap)
        self.addSubview(userImage)
        
      let defa = UserDefaults.standard
        account = UILabel()
        account.text = defa.value(forKey: "account") as? String ?? "未登录"
        account.textColor = UIColor.white
        account.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(account)
        
        nickName = UILabel()
        nickName.text = defa.value(forKey: "password") as? String ?? "未登录"
        nickName.textColor = UIColor.white
        nickName.font = UIFont.systemFont(ofSize: 12)
      
        self.addSubview(nickName)
        
        dataButton = UIButton(type: .system)
        dataButton.setTitle("修改用户信息", for: .normal)
        dataButton.isHidden = true
        dataButton.setTitleColor(UIColor.white, for: .normal)
        dataButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        dataButton.layer.cornerRadius = 4
        dataButton.backgroundColor = UIColor.init(red: 216.0/255.0, green: 52/255.0, blue: 55/255.0, alpha: 1)
     //   dataButton.addTarget(self, action: #selector(userInfo), for: .touchUpInside)
        self.addSubview(dataButton)
        backImage <- [
        Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        ]
        userImage <- [
        Center(),
        CenterX(-50),
        Size(CGSize(width: 60, height: 60))
        ]
        account <- [
        Top(5).to(userImage, .top),
        Left(5).to(userImage, .right),
        Right(15).to(self),
        Height(15)
        ]
        nickName <- [
            Bottom(5).to(userImage, .bottom),
            Left(5).to(userImage, .right),
            Right(15).to(self),
            Height(15)
        ]
        
        dataButton <- [
            Top(20).to(userImage, .bottom),
            CenterX(),
            Width(100),
            Height(30)
        ]
        
    }
    func reload(){
    let defa = UserDefaults.standard
     account.text = defa.value(forKey: "account") as? String ?? "未登录"
     nickName.text = defa.value(forKey: "password") as? String ?? "未登录"
     defa.synchronize()
    }
    func userInfo(){
     self.userinfoBlock?()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
