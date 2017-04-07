//
//  LotteryDetailViewController.m
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryDetailViewController.h"
#import "LotteryDetailViewCell.h"
#import "HttpTools.h"
@interface LotteryDetailViewController ()
@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation LotteryDetailViewController

static NSString *const LotteryDetailViewCellID = @"LotteryDetailViewCell";


- (NSMutableArray *)numArray{
    if (_numArray == nil) {
        _numArray = [NSMutableArray array];
    }
    return _numArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryDetailViewCell" bundle:nil] forCellReuseIdentifier:LotteryDetailViewCellID];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 75;
    [self loadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}
-(void)loadData{
  [HttpTools getWithPath:self.url parms:nil success:^(id JSON) {
      if (JSON){
          NSArray * array = [NSArray arrayWithArray:JSON[@"data"]];
          [_dataArray addObjectsFromArray:array];
          [self.tableView reloadData];
      }
  } :^(NSError *error) {
      
  }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryDetailViewCellID];
    if (_dataArray.count > indexPath.row){
        cell.totalNum = [_dataArray[indexPath.row][@"opencode"] componentsSeparatedByString:@","];
        cell.qishuLB.text = [NSString stringWithFormat:@"第%@期",_dataArray[indexPath.row][@"expect"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    
    return cell;
}




@end
