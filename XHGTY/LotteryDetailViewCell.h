//
//  LotteryDetailViewCell.h
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDetailViewCell : UITableViewCell
@property (nonatomic,strong)NSArray *totalNum;
@property (nonatomic,assign)NSInteger blueNum;
@property (weak, nonatomic) IBOutlet UILabel *qishuLB;

@end
