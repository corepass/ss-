//
//  XYHeardView.h
//  +
//
//  Created by shensu on 17/4/11.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYHeardView : UICollectionReusableView
@property(strong,nonatomic) UILabel * typeLable;
@property(strong,nonatomic) UIButton * addSaveBtn;
@property(copy,nonatomic) void(^ arrayBlock)(NSArray * nArray) ;
@property(copy,nonatomic) void(^ saveBtn)(void);
-(void)reloadArray;
@end
