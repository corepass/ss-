//
//  LotteryDistrInfoViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "LotteryDistrInfoViewController.h"
#import "FXLotteryDistrCell.h"
#import "FXLotteryDIstrInfo.h"
#import "LHDQViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HttpTools.h"


@interface LotteryDistrInfoViewController ()
@property (nonatomic,strong)NSMutableArray *totalRecords;
@end

@implementation LotteryDistrInfoViewController

static NSString *const FXLotteryDistrCellID = @"FXLotteryDistrCell";

-(NSMutableArray *)totalRecords{
    if (_totalRecords == nil) {
        _totalRecords = [NSMutableArray array];
    }
    return _totalRecords;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FXLotteryDistrCell" bundle:nil] forCellReuseIdentifier:FXLotteryDistrCellID];
    self.tableView.rowHeight = 90;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    self.tableView.mj_footer.hidden = YES;
    
    [self loadNewItems];
    
}

int pageNumbering = 1;
- (void)loadMoreItems{
    pageNumbering ++;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    dict[@"p"] = [NSString stringWithFormat:@"%d",pageNumbering];
    
    [HttpTools getWithPath:self.requestURL parms:dict success:^(id JSON) {
        //
        [self.tableView.mj_header endRefreshing];
        NSArray *arr = [FXLotteryDIstrInfo mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = (arr.count < 10);
        
        [self.totalRecords addObjectsFromArray:arr];
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)loadNewItems{
    
    pageNumbering = 1;
    
    [HttpTools getWithPath:self.requestURL parms:nil success:^(id JSON) {
        //
        
        self.totalRecords = [FXLotteryDIstrInfo mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        
        
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        //
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.totalRecords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXLotteryDistrCell *cell = [tableView dequeueReusableCellWithIdentifier:FXLotteryDistrCellID];
    cell.lotteryDistrinfo = self.totalRecords[indexPath.row];
    return cell;
}





@end
