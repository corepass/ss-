//
//  RootView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.headLeftButton];
        [self addSubview:self.headcenterButton];
        [self addSubview:self.headrightButton];
        
        
    }
    
    return self;
    
}

- (UIButton *)headLeftButton{
    
    if (!_headLeftButton) {
        
        _headLeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_headLeftButton setTitle:@"自选一注" forState:UIControlStateNormal];
        _headLeftButton.backgroundColor = [UIColor grayColor];
        [_headLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _headLeftButton.tag = 1010;
        
        [_headLeftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headLeftButton;
}
- (UIButton *)headcenterButton{
    
    if (!_headcenterButton) {
        
        _headcenterButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_headcenterButton setTitle:@"机选一注" forState:UIControlStateNormal];
        _headcenterButton.backgroundColor = [UIColor grayColor];
        [_headcenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _headcenterButton.tag = 1011;
         [_headcenterButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headcenterButton;
}
- (UIButton *)headrightButton{
    
    if (!_headrightButton) {
        
        _headrightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_headrightButton setTitle:@"清空列表" forState:UIControlStateNormal];
        _headrightButton.backgroundColor = [UIColor grayColor];
        [_headrightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _headrightButton.tag = 1012;
         [_headrightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headrightButton;
}
- (void)buttonClick:(UIButton *)button{
    
    self.btnClick(button.tag-1010);
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat buttonWidth = (self.width - 12*4)/3.0;
    CGFloat spaceWidth = 12;
    self.headLeftButton.frame = CGRectMake(spaceWidth, 0, buttonWidth, 35);
    self.headLeftButton.centerY = self.height/2.0;
    
    NSLog(@"%@",NSStringFromCGRect(self.headLeftButton.frame));
    
    self.headcenterButton.frame = CGRectMake(CGRectGetMaxX(self.headLeftButton.frame)+spaceWidth, 0, buttonWidth, 35);
    self.headcenterButton.centerY = self.height/2.0;;
    
    self.headrightButton.frame = CGRectMake(CGRectGetMaxX(self.headcenterButton.frame)+spaceWidth, 0, buttonWidth, 35);
    self.headrightButton.centerY = self.height/2.0;;
    
}

@end
