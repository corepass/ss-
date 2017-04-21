//
//  ChossView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "ChossView.h"

@implementation ChossView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, 130, 25);
    if (self) {
        [self addSubview:self.leftLabel];
        
        [self addSubview:self.centerView];
        [self.centerView addSubview:self.reduceButton];
        [self.centerView addSubview:self.addButton];
        [self.centerView addSubview:self.numberLable];
        [self.centerView addSubview:self.leftLine];
        [self.centerView addSubview:self.rightLine];
        [self.centerView addSubview:self.rightLabel];
        
        
        [self addSubview:self.rightLabel];
     
    }
    
    return self;
    
}
- (UIButton *)reduceButton{
    
    if (!_reduceButton) {
        
        _reduceButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_reduceButton setTitle:@"-" forState:UIControlStateNormal];
        [_reduceButton setTitleColor:[UIColor colorWithHexString:@"#8c8c8c"] forState:UIControlStateNormal];
    }
    return _reduceButton;
}
- (UIButton *)addButton{
    
    if (!_addButton) {
        
        _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithHexString:@"#8c8c8c"] forState:UIControlStateNormal];
    }
    return _addButton;
}
- (UIView *)centerView{
    
    if (!_centerView) {
        
        _centerView = [[UIView alloc]init];
        _centerView.layer.borderColor = [UIColor colorWithHexString:@"#d1d1d1"].CGColor;
        _centerView.layer.borderWidth = 1.0;
    }
    return _centerView;
}
- (UILabel *)leftLabel{
    
    if (!_leftLabel) {
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.text = @"投";
        _leftLabel.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLabel;
}

- (UILabel *)numberLable{
    
    if (!_numberLable) {
        
        _numberLable = [[UILabel alloc]init];
        _numberLable.text = @"1";
        _numberLable.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLable;
}
- (UILabel *)rightLabel{
    
    if (!_rightLabel) {
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.text = @"倍";
        _rightLabel.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}
- (UIView *)leftLine{
    
    if (!_leftLine) {
        _leftLine = [[UIView alloc]init];
        _leftLine.backgroundColor = [UIColor colorWithHexString:@"#d1d1d1"];
        
    }
    return _leftLine;
}
- (UIView *)rightLine{
    
    if (!_rightLine) {
        _rightLine = [[UIView alloc]init];
        _rightLine.backgroundColor = [UIColor colorWithHexString:@"#d1d1d1"];
        
    }
    return _rightLine;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat viewHeight = self.frame.size.height;
    self.leftLabel.frame = CGRectMake(0, 0, 25, viewHeight);
    self.centerView.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, self.frame.size.width - 50, viewHeight);
    self.reduceButton.frame = CGRectMake(0, 0, 25, viewHeight);
    self.addButton.frame = CGRectMake(self.centerView.frame.size.width -25, 0, 25, viewHeight);
    self.numberLable.frame = CGRectMake(CGRectGetMaxX(self.reduceButton.frame), 0, self.centerView.frame.size.width - self.reduceButton.frame.size.width*2, viewHeight);
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.centerView.frame), 0, 25, viewHeight);
    
    self.leftLine.frame = CGRectMake(CGRectGetMaxX(self.reduceButton.frame), 0, 1, viewHeight);
    self.rightLine.frame = CGRectMake(CGRectGetMaxX(self.numberLable.frame), 0, 1, viewHeight);
    
    
}

@end
