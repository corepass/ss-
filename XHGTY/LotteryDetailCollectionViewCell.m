//
//  LotteryDetailCollectionViewCell.m
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryDetailCollectionViewCell.h"

@interface LotteryDetailCollectionViewCell()



@end

@implementation LotteryDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.lotteryBtn.layer.cornerRadius = 20;

    // Initialization code
}


- (void)setNum:(NSString *)num{
   
    [self.lotteryBtn setTitle:num forState:UIControlStateNormal];
}



@end
