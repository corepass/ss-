//
//  CpTableViewCell.h
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface CpTableViewCell : UITableViewCell
@property(copy,nonatomic) AMapPOI * poi;
@property (weak, nonatomic) IBOutlet UIImageView *cpImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
