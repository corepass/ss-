//
//  LotteryDetailViewController.h
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDetailViewController : UITableViewController
@property(nonatomic,strong) NSString * url;
@property (nonatomic,strong)NSMutableArray *numArray;
@property (nonatomic,assign)NSInteger blueNum;
@end
