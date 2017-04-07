//
//  ArticleListViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ArticleListViewController.h"
#import "LHArticle.h"
#import "ArticleViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HttpTools.h"
#import "AppURLdefine.h"

@interface ArticleListViewController ()
@property (nonatomic,strong)NSMutableArray<LHArticle*> *articles;
@end

@implementation ArticleListViewController

- (NSMutableArray<LHArticle *> *)articles{
    if (_articles == nil) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   
    [self loadNewItems];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadNewItems{
    
    [HttpTools getWithPath:kLHDQArticleList parms:@{@"Route":self.articleID} success:^(id JSON) {
        
        NSArray *arr = [LHArticle mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        self.tableView.mj_footer.hidden = (arr.count < 10);
        [self.articles addObjectsFromArray:arr];
        
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        //
    }];
}


int myNum = 1;
- (void)loadMoreItems{
    myNum ++;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"p"] = [NSString stringWithFormat:@"%d",myNum];
    dict[@"Route"] = self.articleID;
    
    
    [HttpTools getWithPath:kLHDQArticleList parms:dict success:^(id JSON) {
        //
        [self.tableView.mj_header endRefreshing];
       
        if ([JSON[@"status"]intValue] == 2) {
            //[MBProgressHUD showError:JSON[@"info"]];
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        NSArray *arr = [LHArticle mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
        
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = (arr.count < 10);
        
        [self.articles addObjectsFromArray:arr];
        [self.tableView reloadData];
        
    } :^(NSError *error) {
       //
       //[MBProgressHUD showError:[error localizedDescription]];
      
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.articles[indexPath.row].post_title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ArticleViewController *articleVC = [[ArticleViewController alloc]init];
    articleVC.targetArticle = self.articles[indexPath.row];
    articleVC.totalArticles = self.articles;
    
    [self.navigationController pushViewController:articleVC animated:YES];
}




@end
