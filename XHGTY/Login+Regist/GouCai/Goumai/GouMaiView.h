//
//  GouMaiView.h
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GouMaiView : UIView
@property(strong,nonatomic) UITextField * textField;
@property(strong,nonatomic) UIButton * buyBtn;
@property(copy,nonatomic) void(^ buyBtnClickBlcok)(void);
@end
