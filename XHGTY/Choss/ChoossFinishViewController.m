//
//  ChoossFinishViewController.m
//  +
//
//  Created by shensu on 17/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ChoossFinishViewController.h"
#import "CpMapViewController.h"
#import "XHGTY-swift.h"
@interface ChoossFinishViewController ()

@end

@implementation ChoossFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保存成功";
//    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"彩票站" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
//    right.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = right;
    [_goBtn setTitle:@"返回" forState:UIControlStateNormal];
    
}
-(void)rightClick{
    CpMapViewController * cp = [[CpMapViewController alloc] init];
    cp.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cp animated:YES];

}
- (IBAction)goBtnClick:(id)sender {
//    MNXHTableViewController * vc = [[MNXHTableViewController alloc] init];
//    vc.title = @"选号记录";
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
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
