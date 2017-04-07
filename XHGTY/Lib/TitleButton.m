//
//  TitleButton.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/5.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "TitleButton.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
#import "UIView+Extension.h"
@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = kFont(15);
        self.size = CGSizeMake(175, 20);
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = 0;
    self.titleLabel.frame = frame;
    
    CGRect frame1 = self.imageView.frame;
    frame1.origin.x = self.titleLabel.frame.size.width +5;
    self.imageView.frame = frame1;
    
}




@end
