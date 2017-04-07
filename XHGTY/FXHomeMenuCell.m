//
//  FXHomeMenuCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/23.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXHomeMenuCell.h"
#import "LotteryKind.h"

@interface FXHomeMenuCell()
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn;

@end

@implementation FXHomeMenuCell

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
