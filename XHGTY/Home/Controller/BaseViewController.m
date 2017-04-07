//
//  BaseViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/17.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDefine.h"

@interface BaseViewController ()

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.jt_fullScreenPopGestureEnabled = YES;
    self.view.backgroundColor = kGlobalColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    BASE_LOG_FUN();
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
