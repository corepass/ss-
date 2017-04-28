//
//  ChossViewController.h
//  +
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MNXHModel;
@interface ChossViewController : UIViewController
@property (nonatomic , strong) NSMutableArray *dataArray;
@property(nonatomic,copy) NSString * qishu;
@property(nonatomic,copy) NSDictionary * dic;
@property(nonatomic,copy) NSString * titleName;
@property(copy,nonatomic) void(^ removesuperBlock)(void);
@end
