//
//  MNXHFootView.m
//  +
//
//  Created by shensu on 17/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNXHFootView.h"

@implementation MNXHFootView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _mnxhLable = [[UILabel alloc]init];
        _mnxhLable.font = [UIFont systemFontOfSize:14];
        _mnxhLable.text = @"已选0注";
        _mnxhLable.backgroundColor =  [[UIColor alloc] initWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];

        [_mnxhLable setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_mnxhLable];
        
        _mnxhBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_mnxhBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_mnxhBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_mnxhBtn addTarget:self action:@selector(mnxhBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_mnxhBtn setUserInteractionEnabled:NO];
        [_mnxhBtn
         setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_mnxhBtn];
        [_mnxhLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(_mnxhBtn.mas_left);
        }];
        [_mnxhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(_mnxhBtn.mas_right);
            make.width.mas_offset(70);
        }];
    }
    return self;
}
-(void)mnxhBtnClick{
    if (self.mnxhBtnBlcok){
        self.mnxhBtnBlcok();
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
