//
//  ChossMianView.h
//  APP
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootView.h"

#import "ChossTableView.h"

@interface ChossMianView : UIView

@property (nonatomic ,strong) FootView *footView;
@property (nonatomic ,strong) ChossTableView *chossTableView;
@property(copy,nonatomic) void(^ deterButtonClickBlock)(NSString * cpNumber,NSString * sumMoney);
@end
