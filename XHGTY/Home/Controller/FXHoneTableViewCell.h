//
//  FXHoneTableViewCell.h
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXHomeModel.h"
@interface FXHoneTableViewCell : UITableViewCell
@property(strong,nonatomic) FXHomeModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
