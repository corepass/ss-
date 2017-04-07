//
//  MyProfileTableViewCell.h
//  YunGou
//
//  Created by x on 16/5/26.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProfileModel.h"
@interface MyProfileTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel * TitleLable;
@property(strong,nonatomic)UILabel * SubtitleLable;
@property(strong,nonatomic)UIImageView * UserImage;
@property(strong,nonatomic)UIImageView * RightImage;
-(void)indexcell:(NSIndexPath*)idex andmodel:(MyProfileModel *)Model;
@end
