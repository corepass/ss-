//
//  MNXHFootView.h
//  +
//
//  Created by shensu on 17/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNXHFootView : UIView
@property(strong,nonatomic)UILabel * mnxhLable;
@property(strong,nonatomic)UIButton * mnxhBtn;
@property(copy,nonatomic) void(^ mnxhBtnBlcok)(void);
@end
