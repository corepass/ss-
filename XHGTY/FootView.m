//
//  FootView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "FootView.h"

@implementation FootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.upView];
        [self.upView addSubview:self.chossleftView];
        [self.upView addSubview:self.chossrightView];
        [self addSubview:self.DownView];
        [self.DownView addSubview:self.moneyLable];
        [self.DownView addSubview:self.determineButton];
        
    }
    
    return self;
    
}
- (ChossView *)chossleftView{
    
    if (!_chossleftView) {
        
        _chossleftView = [[ChossView alloc]initWithFrame:CGRectZero];
        
        
    }
    return _chossleftView;
}
- (ChossView *)chossrightView{
    
    if (!_chossrightView) {
        
        _chossrightView = [[ChossView alloc]initWithFrame:CGRectZero];
        _chossrightView.leftLabel.text = @"追";
        _chossrightView.rightLabel.text= @"期";
        
        
    }
    return _chossrightView;
}
- (UIButton *)determineButton{
    
    if (!_determineButton) {
        
        _determineButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_determineButton setTitle:@"确认购买" forState:UIControlStateNormal];
        _determineButton.backgroundColor = [UIColor redColor];
        [_determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _determineButton;
}
- (UIView *)upView{
    
    if (!_upView) {
        
        _upView = [[UIView alloc]init];
        _upView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    }
    return _upView;
}
- (UIView *)DownView{
    
    if (!_DownView) {
        
        _DownView = [[UIView alloc]init];
        _DownView.backgroundColor = [UIColor colorWithHexString:@"#252526"];
    }
    return _DownView;
}
- (UILabel *)moneyLable{
    
    if (!_moneyLable) {
        
        _moneyLable = [[UILabel alloc]init];
        _moneyLable.text = @"投注金额: 2 元";
        
        _moneyLable.textColor = [UIColor whiteColor];
        _moneyLable.textAlignment = NSTextAlignmentCenter;
        
        
        NSString *str = _moneyLable.text;
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range = NSMakeRange(5, _moneyLable.text.length - 6);
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
        _moneyLable.attributedText = attributedStr;
        
    }
    return _moneyLable;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.upView.frame = CGRectMake(0, 0, self.frame.size.width, 35);
    self.chossleftView.frame = CGRectMake(0,0, 130, 25);
    self.chossleftView.centerY = self.upView.height/2.0;
    self.chossrightView.frame = CGRectMake(self.frame.size.width -130,0, 130, 25);
    self.chossrightView.centerY = self.upView.height/2.0;
    
    self.DownView.frame = CGRectMake(0, CGRectGetMaxY(self.upView.frame), self.frame.size.width, self.frame.size.height - 35);
    self.moneyLable.frame = CGRectMake(30, 0, 130, self.DownView.frame.size.height);
    self.determineButton.frame = CGRectMake(self.frame.size.width - 110, 0, 100, 35);
    self.determineButton.centerY = self.DownView.height/2.0;
    
}

@end
