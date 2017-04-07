//
//  CollectionViewCell.h
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GouCaiModel.h"
@interface CollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) GouCaiModel * model;
@property (weak, nonatomic) IBOutlet UILabel *gouCaiType;
@property (weak, nonatomic) IBOutlet UILabel *gouCaipeilv;

@end
