//
//  MNheadCollectionReusableView.m
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNheadCollectionReusableView.h"

@implementation MNheadCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];

    if (self ){
        self.backgroundColor = [UIColor whiteColor];
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLable];
        
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 50));
        }];
    
    }
    
    return self;
}
@end
