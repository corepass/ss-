//
//  TitleButton.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/5.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = 0;
    frame.size.width += 5;
    self.titleLabel.frame = frame;
    
    CGRect frame1 = self.imageView.frame;
    frame1.origin.x = self.titleLabel.frame.size.width +5;
    self.imageView.frame = frame1;
    
}




@end
