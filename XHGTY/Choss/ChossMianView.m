//
//  ChossMianView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "ChossMianView.h"

@implementation ChossMianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.footView];
        [self addSubview:self.chossTableView];
        
        
    }
    return self;
}

- (FootView *)footView{
    
    if (!_footView) {
        
        _footView = [[FootView alloc]init];
        
    }
    return _footView;
}
- (ChossTableView *)chossTableView{
    
    if (!_chossTableView) {
        _chossTableView = [[ChossTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _chossTableView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.footView.frame = CGRectMake(0, self.height -80, self.width, 80);
    self.chossTableView.frame = CGRectMake(0, 64,self.width, self.height - 64 - self.footView.height);

}

@end
