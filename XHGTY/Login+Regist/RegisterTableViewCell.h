//
//  RegisterTableViewCell.h
//  YunGou
//
//  Created by x on 16/5/24.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegusterCellModel.h"

@interface RegisterTableViewCell : UITableViewCell
@property(strong,nonatomic) RegusterCellModel * Model;
@property(strong,nonatomic) UIImageView * TitleLable;
@property(strong,nonatomic) UITextField * RegisterTextFiled;
@property(strong,nonatomic) UIButton * RegisterButton;
@end
