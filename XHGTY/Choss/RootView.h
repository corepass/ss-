//
//  RootView.h
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView

@property (nonatomic, strong)UIButton *headLeftButton;
@property (nonatomic, strong)UIButton *headcenterButton;
@property (nonatomic, strong)UIButton *headrightButton;
@property (nonatomic, strong) void (^btnClick )(NSInteger index) ;
@end
