//
//  FXLotteryDistrInfoCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXLotteryDistrInfoCell.h"

@interface FXLotteryDistrInfoCell()



@end

@implementation FXLotteryDistrInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setNumber:(NSString *)number{
    [self.lotteryBtn setTitle:number forState:UIControlStateNormal];
}

@end
