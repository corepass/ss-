//
//  XiaZhuView.m
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "XiaZhuView.h"

@implementation XiaZhuView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, self.frame.size.height)];
        _label.textColor = [[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_label];
        
        _xiazhuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_xiazhuBtn setTitle:@"下注" forState:UIControlStateNormal];
        _xiazhuBtn.frame = CGRectMake(self.frame.size.width - 95, 5, 90, 40);
        _xiazhuBtn.layer.cornerRadius = 4;
        [_xiazhuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_xiazhuBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        [_xiazhuBtn addTarget:self action:@selector(xiazhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_xiazhuBtn];

    }
    return self;
}
-(void)xiazhuBtnClick{
    if (_xiazhuBtnClickBlcok){
        self.xiazhuBtnClickBlcok();
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
