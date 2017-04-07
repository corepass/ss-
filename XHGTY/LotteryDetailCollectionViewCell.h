//
//  LotteryDetailCollectionViewCell.h
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LotteryDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy)NSString *num;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn;
@end
