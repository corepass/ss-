//
//  ChossView.h
//  APP
//
//  Created by 马罗罗 on 2017/4/20.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChossView : UIView
@property(copy,nonatomic) void(^chossButtonClick)(NSInteger  index);


@property (nonatomic ,strong) UIButton *addButton;
@property (nonatomic ,strong) UILabel *numberLable;
@property (nonatomic ,strong) UIButton *reduceButton;
@property (nonatomic ,strong) UIView *centerView;

@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;

@property (nonatomic ,strong) UIView *leftLine;
@property (nonatomic ,strong) UIView *rightLine;

@end
