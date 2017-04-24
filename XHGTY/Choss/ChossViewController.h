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
@property (nonatomic , strong) NSArray<MNXHModel *> *dataArray;
@property(nonatomic,copy) NSString * qishu;
@end
