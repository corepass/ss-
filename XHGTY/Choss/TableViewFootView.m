
//
//  TableViewFootView.m
//  NewApp
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "TableViewFootView.h"

@implementation TableViewFootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
     
        [self addSubview:self.determineButton];
        [self addSubview:self.showTextLable];
        //[self addSubview:self.lineView];
        
    }
    
    return self;
    
}

- (UIButton *)determineButton{
    
    if (!_determineButton) {
        
        _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _determineButton.backgroundColor = [UIColor whiteColor];
        _determineButton.layer.borderColor = [UIColor grayColor].CGColor;
        _determineButton.layer.borderWidth = 1;
        _determineButton.layer.masksToBounds = YES;
        _determineButton.layer.cornerRadius =3;
        [_determineButton setImage:[UIImage imageNamed:@"determines"] forState:UIControlStateNormal];
        [_determineButton setImage:[UIImage imageNamed:@"E62180D2-764F-4947-8499-98050869950F.png"] forState:UIControlStateSelected];
        [_determineButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}
- (void)buttonClick:(UIButton *)button{
    
    button.selected = !button.selected;
    NSLog(@"%d",button.selected);
}
- (UILabel *)showTextLable{
    
    if (!_showTextLable) {
        
        _showTextLable = [[UILabel alloc]init];
        _showTextLable.text = @"我已阅读并同意《用户服务协议》";
        _showTextLable.font = [UIFont systemFontOfSize:15.0];
        
        
    }
    return _showTextLable;
}
//- (UIView *)lineView
//{
//    if (!_lineView) {
//        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
//        _lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
//        
//    }
//    return _lineView;
//}
- (void)layoutSubviews{
    
    [super layoutSubviews];

    CGFloat LableWidth = [self withWidth:self.showTextLable.text withFont:[UIFont systemFontOfSize:15.0]];
    self.determineButton.frame = CGRectMake((self.width - LableWidth - 35)/2.0, 0, 20, 20);
    self.determineButton.centerY = self.height/2.0;
    self.showTextLable.frame = CGRectMake(CGRectGetMaxX(self.determineButton.frame), 0, LableWidth, self.height);
    
    //self.lineView.frame = CGRectMake(0, 0, self.width, 1);

    
    
}
-(CGFloat)withWidth:(NSString *)str withFont:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGFloat width = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    return width;
}
@end
