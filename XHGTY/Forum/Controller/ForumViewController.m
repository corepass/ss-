//
//  ForumViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/17.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ForumViewController.h"
#import "FXforumViewCell.h"
#import "FXforum.h"
#import "ForumInfoViewController.h"
#import "FXReplyViewController.h"
#import "FXNoNetWorkView.h"
#import "FTZViewController.h"
#import "FXNavigationController.h"
#import "LoginViewController.h"

@interface ForumViewController ()<requestNetWorDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *forums;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy)NSString *requestURL;
/**网络链接失败*/
@property (nonatomic,strong)FXNoNetWorkView *nonetWorkView;
@end

@implementation ForumViewController

static NSString *const FXforumViewCellID = @"FXforumViewCell";

- (NSMutableArray *)forums{
    if (_forums == nil) {
        _forums = [NSMutableArray array];
    }
    return _forums;
}

- (FXNoNetWorkView *)nonetWorkView{
    if (_nonetWorkView == nil) {
        _nonetWorkView = [FXNoNetWorkView noNetWorkView];
    }
    return _nonetWorkView;
}
- (void)requestNetWorkAgain{
    [self.nonetWorkView removeFromSuperview];
    [self loadNewItems];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nonetWorkView.delegate = self;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"论坛";
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    if (self.isFromMy) {
        self.title = @"我的帖子";
    }
    
    if (self.isSearchReply) {
        self.requestURL = @"Award/Forum/myReply";
        self.title = @"我的回复";
    }else if (self.iscollection){
        self.requestURL = @"Award/Forum/myCollect/";
        self.title = @"我的收藏";
    }else{
        self.requestURL = @"Award/Forum/index";
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    self.tableView.mj_footer.hidden = YES;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"FXforumViewCell" bundle:nil] forCellReuseIdentifier:FXforumViewCellID];
    self.tableView.estimatedRowHeight = 44;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadNewItems];
    

    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"发帖子" style:UIBarButtonItemStyleDone target:self action:@selector(popTZ)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)popTZ{
    
    if (kAccount.uid) {
        FTZViewController *FTZVC = [[FTZViewController alloc]init];
        [self.navigationController pushViewController:FTZVC animated:YES];
    }else{
       
        LoginViewController *loginVC =  [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];;
            [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

int pageNumber = 1;
- (void)loadMoreItems{
    pageNumber ++;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"p"] = [NSString stringWithFormat:@"%d",pageNumber];
    
    if (self.isFromMy) {
        dict[@"user_id"] = kAccount.uid;
    }else if (self.iscollection){
        dict[@"user_id"] = kAccount.uid;
    }
    
    
    
    
    
    
    NSString *requestURL = [NSString stringWithFormat:@"http://app.lh888888.com/%@",self.requestURL];
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:requestURL parms:dict success:^(id JSON) {
        [self.tableView.mj_header endRefreshing];
        [self.nonetWorkView removeFromSuperview];
        
        if ([JSON[@"status"]intValue] == 2) {
            [MBProgressHUD showError:JSON[@"info"]];
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        NSArray *arr = [FXforum mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
        
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = (arr.count < 10);
        
        [self.forums addObjectsFromArray:arr];
        [self.tableView reloadData];
    } :^(NSError *error) {
        if ([[error localizedDescription]containsString:@"互联网"]) {
            if (self.forums.count) {
                [MBProgressHUD showError:[error localizedDescription]];
            }else{
                [self.view addSubview:self.nonetWorkView];
            }
        }
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

- (void)loadNewItems{
    pageNumber = 1;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.isFromMy) {
        dict[@"user_id"] = kAccount.uid;
    }else if (self.iscollection){
        dict[@"user_id"] = kAccount.uid;
    }else{
        dict = nil;
    }
    
    
    NSString *requestURL = [NSString stringWithFormat:@"http://app.lh888888.com/%@",self.requestURL];
    
   [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:requestURL parms:dict success:^(id JSON) {
       [self.tableView.mj_header endRefreshing];
       [self.nonetWorkView removeFromSuperview];
       
       [self.forums removeAllObjects];
       
       NSArray *arr = [FXforum mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
       
       if ( arr.count == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 300, 40)];
           label.text = @"暂时没有信息出现，请稍后再来查看";
           label.textColor = [UIColor blackColor];
           label.center = self.view.center;
           [self.view addSubview:label];
           
       }
       
       self.tableView.mj_footer.hidden = (arr.count < 10);
       
       [self.forums addObjectsFromArray:arr];
       [self.tableView reloadData];
    } :^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if ([[error localizedDescription]containsString:@"互联网"]) {
            if (self.forums.count) {
                [MBProgressHUD showError:[error localizedDescription]];
            }else{
                [self.view addSubview:self.nonetWorkView];
            }
        }
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.forums.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXforumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXforumViewCellID];
    cell.forum = self.forums[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSearchReply) {
        FXReplyViewController *replyVC = [[FXReplyViewController alloc]init];
        
        FXforum *forum =  self.forums[indexPath.row];
        replyVC.forumID = forum.ID;
        [self.navigationController pushViewController:replyVC animated:YES];
    }else{
        ForumInfoViewController *infoVC = [[ForumInfoViewController alloc]init];
        infoVC.forum = self.forums[indexPath.row];
        if (self.isFromMy) {
            infoVC.iscollection = YES;
        }
        
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    
    
}

@end
