//
//  WebViewXib.m
//  +
//
//  Created by shensu on 17/3/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "WebViewXib.h"
#import "Masonry.h"
@implementation WebViewXib
-(instancetype)initWithFrame:(CGRect)frame
{  self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.goback = [UIButton buttonWithType:UIButtonTypeSystem];

        [self.goback setBackgroundImage:[UIImage imageNamed:@"1-2"] forState:UIControlStateNormal];

        self.goback.showsTouchWhenHighlighted = NO;
        self.goback.tag = 1;
        [self.goback addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goback];
        
        self.goforward = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.goforward setBackgroundImage:[UIImage imageNamed:@"1-1"] forState:UIControlStateNormal];
        self.goforward.showsTouchWhenHighlighted = NO;
         self.goforward.tag = 2;
        [self.goforward addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goforward];
        
        self.goreloadData = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.goreloadData setBackgroundImage:[UIImage imageNamed:@"1-3"] forState:UIControlStateNormal];
        self.goreloadData.tag = 3;
        [self.goreloadData addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.goreloadData.showsTouchWhenHighlighted = NO;
        [self addSubview:self.goreloadData];
        
        CGFloat sapce = (self.frame.size.width - 150)/6 ;
        
        [self.goback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(sapce);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_goreloadData);
            make.right.mas_equalTo(_goreloadData.mas_left).offset(-sapce);
        
        }];
        
        [_goreloadData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goback.mas_right).offset(sapce);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_goforward);
            make.right.mas_equalTo(_goforward.mas_left).offset(-sapce);
            
        }];
        
        [self.goforward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goreloadData.mas_right).offset(sapce);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(_goback);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-sapce);
            
        }];
    
    }
    return self;
}
-(void)buttonClick:(UIButton *)btn {
    __weak __typeof (UIButton *) weak = btn;
    if (self.WebViewBlock != nil){
        self.WebViewBlock(weak.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
