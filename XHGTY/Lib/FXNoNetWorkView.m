//
//  FXNoNetWorkView.m
//  CityCook
//
//  Created by 杨健 on 16/5/30.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import "FXNoNetWorkView.h"

@interface FXNoNetWorkView()

@end

#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH ([[UIScreen mainScreen] bounds].size.height)
@implementation FXNoNetWorkView

+(instancetype)noNetWorkView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"FXNoNetWorkView" owner:self options:nil]lastObject];
}


- (IBAction)buttonClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(requestNetWorkAgain)]) {
        [self.delegate requestNetWorkAgain];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(kScreenW *0.5 - 75, (kScreenH - 64 - 50)*0.5 - 100, 150, 200);
}

@end
