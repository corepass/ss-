//
//  HomegpcCollectionViewCell.h
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gpcModel.h"
@interface HomegpcCollectionViewCell : UICollectionViewCell
@property (copy,nonatomic) gpcModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *gpcImage;
@property (weak, nonatomic) IBOutlet UILabel *gpcTitle;
@property (weak, nonatomic) IBOutlet UILabel *gpcSubTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subLeft;

@end
