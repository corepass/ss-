//
//  KJpushTableViewController.swift
//  shensu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 杨健. All rights reserved.
//

import UIKit

class KJpushTableViewController: UITableViewController {
    var dataArray = [["title":"双色球","subtitle":"每周二、周四、日开奖","isopen":true],["title":"大乐透","subtitle":"每周一、周三、六开奖","isopen":false],["title":"3D","subtitle":"每天开奖 包括试机号提醒","isopen":false]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开奖推送设置"
        self.tableView.tableHeaderView = HeardView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 50))
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 0.01))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        if dataArray.count > indexPath.row {
            let segu = UISwitch()
            segu.isOn = (dataArray[indexPath.row]["isopen"]  as? Bool)!
            cell?.accessoryView = segu
            cell?.textLabel?.text = dataArray[indexPath.row]["title"] as! String?
            cell?.detailTextLabel?.text = dataArray[indexPath.row]["subtitle"] as! String?
            cell?.detailTextLabel?.textColor = UIColor.darkGray
            
        }
        cell?.selectionStyle = .none

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

class HeardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lable = UILabel(frame: frame)
        lable.text = "打开设置即可在开奖后立即收到推送消息，获知开奖号码"
        lable.textAlignment = .center
        lable.textColor = UIColor.orange
        lable.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(lable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
