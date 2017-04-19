//
//  FXNavigationController.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXNavigationController.h"

@interface FXNavigationController ()

@end

@implementation FXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance]setTranslucent:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage_w"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    left.tintColor = [UIColor whiteColor];
    viewController.navigationItem.leftBarButtonItem =  left;
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
