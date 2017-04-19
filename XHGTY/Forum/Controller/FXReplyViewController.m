//
//  FXReplyViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/10.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXReplyViewController.h"
#import "FXReplyViewCell.h"
#import "FXReply.h"
#import "FXforum.h"

@interface FXReplyViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)NSMutableArray *replies;
@property (nonatomic,strong)FXforum *forum;


@end

@implementation FXReplyViewController

static NSString  *const FXReplyViewCellID = @"FXReplyViewCell";

- (NSMutableArray *)replies{
    if (_replies == nil) {
        _replies = [NSMutableArray array];
    }
    return _replies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"回复详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FXReplyViewCell" bundle:nil] forCellReuseIdentifier:FXReplyViewCellID];
    self.tableView.rowHeight = 125;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    self.tableView.mj_footer.hidden = YES;
    
    [self loadNewItems];
}

int currentPageNum = 1;
- (void)loadMoreItems{
    currentPageNum ++ ;
    
    
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://app.lh888888.com/Award/Forum/myReplyInfo" parms:@{@"forum_id":self.forumID,@"p":[NSString stringWithFormat:@"%d",currentPageNum]}  success:^(id JSON) {
        [self.tableView.mj_footer endRefreshing];
      
        
        [self.replies removeAllObjects];
        
        NSArray *arr = [FXReply mj_objectArrayWithKeyValuesArray:JSON[@"replyinfo"]];
        
        self.tableView.mj_footer.hidden = (arr.count < 10);
        [self.replies addObjectsFromArray:arr];
        [self.tableView reloadData];
    } :^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

- (void)loadNewItems{
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://app.lh888888.com/Award/Forum/myReplyInfo" parms:@{@"forum_id":self.forumID} success:^(id JSON) {
        [self.tableView.mj_footer endRefreshing];
        
        self.forum = [FXforum mj_objectWithKeyValues:JSON[@"author"]];
        
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:self.forum.avatar]];
        
      
        self.nameLabel.text = self.forum.user_nicename;
        self.contentLabel.text = self.forum.content;
        self.timeLabel.text = self.forum.add_time;
        self.titleLabel.text = self.forum.title;
        
        
        [self.replies removeAllObjects];
        
        NSArray *arr = [FXReply mj_objectArrayWithKeyValuesArray:JSON[@"replyinfo"]];
        
        self.tableView.mj_footer.hidden = (arr.count < 10);
        [self.replies addObjectsFromArray:arr];
        [self.tableView reloadData];
    } :^(NSError *error) {
       [self.tableView.mj_footer endRefreshing];
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXReplyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXReplyViewCellID];
    cell.reply = self.replies[indexPath.row];
    return cell;
}



@end
