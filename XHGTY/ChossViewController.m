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
@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation ChossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ChossMianView *chossMianView = [[ChossMianView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    chossMianView.chossTableView.dataArray = self.dataArray;
    [self.view addSubview:chossMianView];
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
        [_dataArray addObject:@"1"];
        [_dataArray addObject:@"2"];
        [_dataArray addObject:@"3"];
    }
    return _dataArray;
}


@end

