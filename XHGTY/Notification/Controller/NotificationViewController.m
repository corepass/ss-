//
//  NotificationViewController.m
//  YunGou
//
//  Created by x on 16/6/2.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "NotificationViewController.h"
#import "MJRefresh.h"
#import "NotificationTableViewCell.h"
#import "NotificationModel.h"

#import "OCwebViewController.h"
@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView * NotificationTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(strong,nonatomic) NSMutableArray * NotificationArray;
@property(assign,nonatomic) NSInteger currentPage;
@end

@implementation NotificationViewController
-(void)getData{
    
    NSString * patch = [[NSBundle mainBundle] pathForResource:@"NotiMsg" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:patch];
    for (NSDictionary * dic  in array) {
        NotificationModel * model = [[NotificationModel alloc]init];
        model.TitleLable = dic[@"title"];
        model.SubLable = dic[@"time"];
        model.isRead = NO;
        model.url = dic[@"url"];
        [_dataArray addObject:model];
    }
    [self.NotificationTableView reloadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dataArray = [[NSMutableArray alloc]init];
    _currentPage = 1;
    [self getData];

    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";

    _NotificationTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _NotificationTableView.delegate = self;
    _NotificationTableView.dataSource = self;
    _NotificationTableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_NotificationTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
            return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    NotificationModel * Model = [_dataArray objectAtIndex:indexPath.section];
    static NSString * cellindetifi;
    if (Model.isRead) {
       cellindetifi = @"isResdNotification";
    }else
    {
       cellindetifi = @"unReadNotification";
    }
    NotificationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindetifi];
    if (!cell) {
        cell = [[NotificationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellindetifi];
          }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.Model = [_dataArray objectAtIndex:indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.NotificationTableView reloadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   NotificationModel * model = _dataArray[indexPath.section];
    OCwebViewController * web = [[OCwebViewController alloc]init];
    web.url = [NSURL URLWithString:model.url];
    web.title = @"公告";
    [self.navigationController pushViewController:web animated:YES];
  //   NotificationModel * Model = [_dataArray objectAtIndex:indexPath.section];
  //  DetaNotifiViewController *  DetaNotifi = [[DetaNotifiViewController alloc] init];
//    DetaNotifi.ID = Model.ID;
//    [self.navigationController pushViewController:DetaNotifi animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

            return 67;
   
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
