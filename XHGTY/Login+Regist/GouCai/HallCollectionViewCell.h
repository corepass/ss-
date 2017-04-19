//
//  HallCollectionViewCell.h
//  +
//
//  Created by shensu on 17/4/17.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LotteryKind;
@interface HallCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIButton * buton ;
@property (nonatomic,strong)LotteryKind *kind;
@property (nonatomic,copy)NSString *lotteryName;
@end
