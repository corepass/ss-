//
//  BallTableViewController.m
//  +
//
//  Created by shensu on 17/4/19.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "BallTableViewController.h"
#import "BallTableViewCell.h"
#import "BallModel.h"
#import "FXWebViewController.h"
@interface BallTableViewController ()
@property(strong,nonatomic) UISegmentedControl * segumented;
@property(strong,nonatomic) NSMutableArray<BallModel *> * dataArray;
@property(assign,nonatomic) BOOL isopen;
@end

@implementation BallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _dic[@"title"];
    _dataArray = [[NSMutableArray alloc] init];
    [self setsegument];
    [self setData];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 0.01)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setData];
        [_dataArray removeAllObjects];
        [self.tableView reloadData];
    }];
}
-(void)setsegument{
    NSArray * titleArray = @[@"即时",@"完场"];
    self.segumented = [[UISegmentedControl alloc]initWithItems:titleArray];
    self.segumented.frame = CGRectMake(0, 0, 250, 40);
    self.segumented.tintColor = [UIColor whiteColor];
    self.segumented.selectedSegmentIndex = 0;
    [self.segumented addTarget:self action:@selector(segumentedClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segumented;


    
    
}
-(void)setData{
    NSString * url;
    if (_isopen){
        url = _dic[@"open"];
    }else{
        url = _dic[@"unopen"];
    }

    //http://api.datacenter.woying.com/soccer/score?lType=1&statType=1&issue=&sv2=1
    //http://api.datacenter.woying.com/soccer/score?lType=1&statType=2&issue=2017-04-19&sv2=1
  [HttpTools POSTWithPath:url parms:nil success:^(id JSON) {
      [self.tableView.mj_header endRefreshing];
      if (JSON){
          if ([JSON[@"status"] integerValue] == 1){
              _dataArray = [BallModel mj_objectArrayWithKeyValuesArray:JSON[@"dataObj"][@"List"]];
              [self.tableView reloadData];
          }
      }
  } :^(NSError *error) {
       [self.tableView.mj_header endRefreshing];
      [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [SVProgressHUD dismiss];
      });
  }];

}
-(void)segumentedClick:(UISegmentedControl * )sender{
    if (sender.selectedSegmentIndex == 0){
        _isopen = NO;
    }else{
        _isopen = YES;
    }
    [self setData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count > indexPath.section){
        BallModel * model = _dataArray[indexPath.section];
        FXWebViewController *  web = [[FXWebViewController alloc] init];
        web.titleName = @"赛事分析";
        web.accessUrl = model.Xi;
        web.isHTML = YES;
        [self.navigationController pushViewController:web animated:YES];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellidentifi = @"cell";
    BallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifi];
    if (cell == nil ){
    cell = [[[NSBundle mainBundle] loadNibNamed:@"BallTableViewCell" owner:self options:nil] firstObject];
    
    }
    if (_dataArray.count > indexPath.section){
        cell.model = _dataArray[indexPath.section];
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
