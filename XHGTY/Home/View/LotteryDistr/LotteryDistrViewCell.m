//
//  LotteryDistrViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "LotteryDistrViewCell.h"
#import "FXLotteryDistr.h"

@interface LotteryDistrViewCell()

@property (weak, nonatomic) IBOutlet UIButton *namebutton;

@end

@implementation LotteryDistrViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name{
    
    [self.namebutton setTitle:name forState:UIControlStateNormal];
}

- (void)setLotteryDist:(FXLotteryDistr *)lotteryDist{
   
    [self.namebutton setTitle:lotteryDist.alias forState:UIControlStateNormal];
  
}

@end
