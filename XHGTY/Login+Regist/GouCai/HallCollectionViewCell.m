//
//  HallCollectionViewCell.m
//  +
//
//  Created by shensu on 17/4/17.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "HallCollectionViewCell.h"
#import "LotteryKind.h"
@interface HallCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn;
@end
@implementation HallCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buton = self.lotteryBtn;
    // Initialization code
}



-(void)setKind:(LotteryKind *)kind{
    _kind = kind;
    
    [self.lotteryBtn setTitle:kind.name forState:UIControlStateNormal];
    [self.lotteryBtn setImage:[UIImage imageNamed:kind.name] forState:UIControlStateNormal];
}
- (void)setLotteryName:(NSString *)lotteryName{
    _lotteryName = lotteryName;
    
    [self.lotteryBtn setTitle:lotteryName forState:UIControlStateNormal];
    [self.lotteryBtn setImage:[UIImage imageNamed:lotteryName] forState:UIControlStateNormal];
    
}


@end
