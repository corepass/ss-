//
//  ZhuanjiaTableViewCell.h
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuanjiaModel.h"
@interface ZhuanjiaTableViewCell : UITableViewCell
@property(strong,nonatomic) ZhuanjiaModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subLable;
@property (weak, nonatomic) IBOutlet UILabel *yueLable;
@property (weak, nonatomic) IBOutlet UILabel *yueget;

@end
