//
//  KJTableViewCell.swift
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class KJTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var qishu: UILabel!
    @IBOutlet weak var cpType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setModel(){
     let array = Array<Any>()
        for i in 0..<array.count {
            let lable = UILabel()
            lable.frame = CGRect(x: 30 * i , y: 5, width: 25, height: 25)
            
            lable.layer.cornerRadius = 12.5
            if i == array.count - 1{
                lable.backgroundColor = UIColor.init(red: 27.0/255.0, green: 236/255.0, blue: 224/255.0, alpha: 1)
            }else{
                lable.backgroundColor = UIColor.init(red: 253.0/255.0, green: 127/255.0, blue: 34/255.0, alpha: 1)
            }
            
            lable.layer.masksToBounds = true
            lable.text = "\(array[i])"
            lable.textAlignment = .center
            lable.textColor = UIColor.white
            lable.font = UIFont.systemFont(ofSize: 14)
            
            backView.addSubview(lable)
        }

    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
