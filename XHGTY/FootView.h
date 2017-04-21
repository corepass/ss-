//
//  FootView.h
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChossView.h"

@interface FootView : UIView
@property (nonatomic , strong) ChossView *chossleftView;
@property (nonatomic , strong) ChossView *chossrightView;
@property (nonatomic , strong) UIView *upView;
@property (nonatomic, strong)  UIView *DownView;
@property (nonatomic ,strong) UILabel *moneyLable;
@property (nonatomic ,strong) UIButton *determineButton;

@end
