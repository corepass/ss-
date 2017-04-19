//
//  BallTableViewCell.h
//  +
//
//  Created by shensu on 17/4/19.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallModel.h"
@interface BallTableViewCell : UITableViewCell
@property(copy,nonatomic) BallModel * model;
@property (weak, nonatomic) IBOutlet UILabel *opentime;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *bstime;
@property (weak, nonatomic) IBOutlet UIImageView *oneteam;
@property (weak, nonatomic) IBOutlet UIImageView *twoteam;
@property (weak, nonatomic) IBOutlet UILabel *onename;
@property (weak, nonatomic) IBOutlet UILabel *twoname;
@property (weak, nonatomic) IBOutlet UILabel *bfLable;

@end
