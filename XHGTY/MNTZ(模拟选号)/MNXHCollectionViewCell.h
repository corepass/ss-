//
//  MNXHCollectionViewCell.h
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNXHModel.h"
@interface MNXHCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLable;
@property(copy,nonatomic) MNXHModel * model;
@end
