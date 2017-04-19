//
//  FXPLAndGYViewController.h
//  CityCook
//
//  Created by 杨健 on 16/8/16.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXWebViewController : UIViewController

/** 访问地址 */
@property (nonatomic,copy)NSString * accessUrl;

@property (nonatomic,copy)NSString *titleName;

@property (nonatomic, assign) BOOL  isneed;

@property(nonatomic ,assign) BOOL isHTML;
@end
