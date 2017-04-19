//
//  MytabBarViewController.m
//  +
//
//  Created by shensu on 17/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MytabBarViewController.h"
#import "LoginViewController.h"
#import "XHGTY-swift.h"
@interface MytabBarViewController ()<UITabBarControllerDelegate >

@end

@implementation MytabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 3 ){
        if (![[Apploction default] isLogin]){
  
     
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
