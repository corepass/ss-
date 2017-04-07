//
//  NotificationTableViewCell.h
//  YunGou
//
//  Created by x on 16/6/2.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
@interface NotificationTableViewCell : UITableViewCell
@property (strong,nonatomic) NotificationModel * Model;
@property (strong,nonatomic) UILabel * TitleLable;
@property (strong,nonatomic) UILabel * SubclassLable;
@property (strong,nonatomic) UIView * RedView;
@property (strong,nonatomic) UILabel * DetaLable;
@end
