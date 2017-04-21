//
//  MNXHHeardView.m
//  +
//
//  Created by shensu on 17/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNXHHeardView.h"

@implementation MNXHHeardView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        _qishu = [[UILabel alloc] init];
        _qishu.font = [UIFont systemFontOfSize:14];
        _qishu.textColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
        [self addSubview:_qishu];
        
        _rule = [[UILabel alloc] init];
        _rule.font = [UIFont systemFontOfSize:14];
        [self addSubview:_rule];
        
        _openNumber = [[UILabel alloc] init];
        [_openNumber setTextAlignment:NSTextAlignmentCenter];
        _openNumber.font = [UIFont systemFontOfSize:14];
        [self addSubview:_openNumber];
     
        [_qishu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_openNumber);
            make.right.mas_equalTo(_openNumber.mas_left);
        }];
        [_openNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(_qishu.mas_right);
            make.width.mas_offset(180);
        }];
        [_rule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(_openNumber.mas_bottom);
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(15);
            make.height.mas_offset(30);
        }];
        
        
    }
 
    return  self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
