//
//  NewTableViewCell.swift
//  bjscpk10
//
//  Created by shensu on 17/3/23.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    func setModel(dic:Dictionary<String,Any>){
    ImageView.image = UIImage(data: try! Data.init(contentsOf: URL.init(string: dic["image"]! as! String)!))
    TitleLable.text = dic["title"] as! String?
    subTitle.text = dic["contents"] as! String?
    
    }
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
