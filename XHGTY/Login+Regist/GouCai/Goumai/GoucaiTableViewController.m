//
//  GoucaiTableViewController.m
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "GoucaiTableViewController.h"
#import "GoucaiTableViewCell.h"
#import "GouCaiModel.h"
#import "XiaZhuView.h"
#import "AppDefine.h"
#import "XHGTY-swift.h"
#import "ChoossFinishViewController.h"
@interface GoucaiTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic)  UIBarButtonItem * right;
@property(strong,nonatomic)  XiaZhuView * xiazhu;
@end

@implementation GoucaiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = kGlobalColor;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];
  
    _xiazhu = [[XiaZhuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    _xiazhu.backgroundColor = [UIColor whiteColor];
    NSInteger count = _dataArray.count;

    _xiazhu.label.text = [NSString stringWithFormat:@"%ld注",(long)count];
    __weak __typeof (self) weak = self;
    _xiazhu.xiazhuBtnClickBlcok = ^(){
        
        NSMutableArray * savaArray = [[NSMutableArray alloc] init];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]stringByAppendingFormat:@"/Caches"];
        NSString * file = [NSString stringWithFormat:@"%@/caipiao.data",path];
      
        for (GouCaiModel * model in weak.dataArray) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            dic[@"name"] = @"PC蛋蛋";
            dic[@"qishu"] = model.qishu;
            dic[@"sumMoney"] = weak.number;
            dic[@"status"] = @"待开奖";
            NSString * str = @"";
            for ( GouCaiModel * model in weak.dataArray) {
               str = [str stringByAppendingString:[NSString stringWithFormat:@"%@|", model.type]];
            }
            str = [str substringWithRange:NSMakeRange(0, str.length -1)];
            dic[@"number"] = str;
            [savaArray addObject:dic];
        }

        if([NSArray arrayWithContentsOfFile:file]){
            [savaArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:file]];
        }
        [savaArray writeToFile:file atomically:YES];
        ChoossFinishViewController * touzhu = [[ChoossFinishViewController alloc]init];
        [weak.navigationController pushViewController:touzhu animated:YES];
        
    };
    if(_dataArray.count != 0){
        [_xiazhu.xiazhuBtn setBackgroundColor:[[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1]];
    }else{
        [_xiazhu.xiazhuBtn setBackgroundColor:[UIColor lightGrayColor]];
        _xiazhu.xiazhuBtn.enabled = NO;
    }
    [self.view addSubview:_xiazhu];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellidentifi = @"cell";
    GoucaiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifi];
    if (cell == nil ){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoucaiTableViewCell" owner:self options:nil] firstObject];
    }
    if (indexPath.row == 0){
    cell.type.text = @"号码";
    cell.beilv.text = @"赔率";
    cell.price.text = @"金额";
    cell.type.textColor = [UIColor grayColor];
    cell.beilv.textColor = [UIColor grayColor];
    cell.price.textColor = [UIColor grayColor];
    }else {
    GouCaiModel * model = _dataArray[indexPath.row - 1];
    cell.type.text = model.type;
    cell.beilv.text = model.peilv;
    cell.price.text = self.number;
    cell.beilv.textColor = [UIColor grayColor];
    }
    if (indexPath.row%2==0){
        cell.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:225.0/255.0 blue:210.0/255.0 alpha:1];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0){
        return YES;
    }
    return NO;
}
-(void)selectedAll{
    static BOOL selected = YES;
    if (!selected) {
        selected = YES;
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        }
       
    }else{
    selected = NO;
      
    for (int i = 1; i <= self.dataArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i-1 inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            //            cell.selected = NO;
        }
       
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.dataArray removeObjectAtIndex:indexPath.row -1];
        [self.tableView reloadData];
    }
    NSInteger count = _dataArray.count;
    NSInteger price = [_number integerValue];
    _xiazhu.label.text = [NSString stringWithFormat:@"%ld注%ld元",count,count*price];
    if(_dataArray.count != 0){
        [_xiazhu.xiazhuBtn setBackgroundColor:[[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1]];
        return ;
    }else{
        [_xiazhu.xiazhuBtn setBackgroundColor:[UIColor lightGrayColor]];
         _xiazhu.xiazhuBtn.enabled = NO;
    }

}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
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
