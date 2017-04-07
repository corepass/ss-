//
//  BaseTableViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/17.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AppDefine.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.jt_fullScreenPopGestureEnabled = YES;
    self.tableView.backgroundColor = kGlobalColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    BASE_LOG_FUN();
}

@end
