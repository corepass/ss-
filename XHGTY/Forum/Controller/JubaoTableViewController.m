//
//  JubaoTableViewController.m
//  +
//
//  Created by shensu on 17/5/5.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "JubaoTableViewController.h"

@interface JubaoTableViewController ()
@property(strong,nonatomic) NSArray * dataArray;
@property(strong,nonatomic) NSIndexPath * index;
@end

@implementation JubaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"举报";
    _dataArray = @[@"欺诈骗钱",@"无理谩骂",@"政治敏感",@"色情低俗"];
    self.tableView.tableHeaderView = [self addHeadView];
    self.tableView.tableFooterView = [self addFootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UILabel *)addHeadView{
    UILabel * lab = [[UILabel alloc] init];
    lab.text = @"  请选择举报原因";
    lab.frame = CGRectMake(15, 0, self.view.width, 50);
    lab.font = [UIFont systemFontOfSize:16];
    return lab;
}
-(UIView *)addFootView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.size = CGSizeMake(self.view.width - 100, 44);
    btn.center = view.center;
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    btn.layer.cornerRadius = 4;
    [view addSubview:btn];
    return view;
}
-(void)btnClick{
    if (!_index){
      [SVProgressHUD showErrorWithStatus:@"请选择举报原因"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return ;
    }
    [SVProgressHUD showInfoWithStatus:@"举报中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"已经举报成功！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellindetifi = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindetifi];
    if (cell == nil ){
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellindetifi];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath;
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
