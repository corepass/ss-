//
//  CollectionViewCell.m
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
-(void)setModel:(GouCaiModel *)model{
    self.gouCaiType.text = model.type;
    self.gouCaipeilv.text = model.peilv;
    if (model.isSelected) {
        self.backgroundColor = [[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1];
        self.gouCaiType.textColor = [UIColor whiteColor];
        self.gouCaipeilv.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.gouCaiType.textColor = [UIColor blackColor];
        self.gouCaipeilv.textColor =[[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1];
    }
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = [[UIColor alloc]initWithRed:240.0/255.0 green:240.0/255.0  blue:240.0/255.0  alpha:1].CGColor;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 4.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.frame].CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Initialization code
}

@end
