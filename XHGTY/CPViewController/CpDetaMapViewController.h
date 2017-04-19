//
//  CpDetaMapViewController.h
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface CpDetaMapViewController : UIViewController
@property(copy,nonatomic) AMapPOI * poi;
@property(copy,nonatomic) CLLocation * location;
@end
