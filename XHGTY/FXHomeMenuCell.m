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
    self.titleLable.text = kind.name;
    self.iconImage.image = [UIImage imageNamed:kind.name];
//    [self.lotteryBtn setTitle:kind.name forState:UIControlStateNormal];
//    [self.lotteryBtn setImage:[UIImage imageNamed:kind.name] forState:UIControlStateNormal];
}
- (void)setLotteryName:(NSString *)lotteryName{
    _lotteryName = lotteryName;
    
    
    if([_lotteryName isEqualToString:@"开奖记录"]){
        self.titleLable.text = @"彩民论坛";
        self.iconImage.image = [UIImage imageNamed:_lotteryName];
   
    }else if ([_lotteryName isEqualToString:@"视频开奖"]){
    
        self.titleLable.text = @"体验中心";
        self.iconImage.image = [UIImage imageNamed:_lotteryName];
    }else{
        self.titleLable.text = _lotteryName;
        self.iconImage.image = [UIImage imageNamed:_lotteryName];
    }
  
    
}

@end
