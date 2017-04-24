//
//  ChossViewController.m
//  +
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ChossViewController.h"
#import "ChossMianView.h"
@interface ChossViewController ()

@end

@implementation ChossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注单";
    ChossMianView *chossMianView = [[ChossMianView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    chossMianView.chossTableView.dataArray = self.dataArray;
    [self.view addSubview:chossMianView];
}




@end

