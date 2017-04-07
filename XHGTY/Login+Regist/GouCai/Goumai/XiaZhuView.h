//
//  XiaZhuView.h
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiaZhuView : UIView
@property(strong,nonatomic) UILabel * label;
@property(strong,nonatomic) UIButton * xiazhuBtn;
@property(copy,nonatomic) void(^ xiazhuBtnClickBlcok)(void);
@end
