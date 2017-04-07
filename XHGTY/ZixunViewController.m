//
//  ZixunTableViewController.m
//  +
//
//  Created by 杨健 on 2016/12/30.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ZixunViewController.h"
#import "NALLabelsMatrix.h"
#import "FXZixun.h"
#import "HttpTools.h"
#import "MJExtension.h"
#import "ZiXunTableViewCell.h"
#import "FXNewsViewCell.h"
#import "FXNews.h"
#import "MJRefresh.h"
#import "FXWebViewController.h"
#import "UIBarButtonItem+Exstion.h"
#import "SVProgressHUD.h"

@interface ZixunViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong)NSMutableArray *zixuns;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZixunViewController

static NSString *const FXNewsViewCellID = @"FXNewsViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FXNewsViewCell" bundle:nil] forCellReuseIdentifier:FXNewsViewCellID];
    
    self.tableView.rowHeight = 80;
   
    
//    [HttpTools getWithPath:@"http://tu.hgoobb.com/huangguan.php" parms:nil success:^(id JSON) {
//        //
//        
//        NSString *str = JSON[@"in_start"];
//        if ([str isEqualToString:@"1"]) {//开关开启 显示新闻数据
//            [self requestNews];
//            self.title = @"资讯";
//            self.tableView.hidden = NO;
//        }else{  //开关关闭 显示webView
//            self.webView.hidden = NO;
//            self.title = @"客服";
//            NSURL *url = [NSURL URLWithString:JSON[@"kefu"]];
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
//            [self.webView loadRequest:request];
//        }
//        
//    } :^(NSError *error) {
//        //
//    }];
    
//    
      [self requestNews];
      self.title = @"资讯";
      self.tableView.hidden = NO;

//    self.webView.hidden = NO;
//    self.title = @"客服";
//    NSURL *url = [NSURL URLWithString:@"http://kf1.learnsaas.com/chat/chatClient/chatbox.jsp?companyID=675512&configID=56938&jid=2467001460"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImge:@"refreshPic" selectedIcon:@"refreshPic" target:self andSEL:@selector(refreshClick)];
}

- (void)refreshClick{
    [self.webView reload];
}

- (void)requestNews {
   
    [HttpTools getWithPath:@"http://v.juhe.cn/toutiao/index" parms:@{@"key":@"027c40bc304d03c6fcf0ae33f0663bbf",@"type":@"top"} success:^(id JSON) {
        //
        self.zixuns = [FXNews mj_objectArrayWithKeyValuesArray:JSON[@"result"][@"data"]];
        
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        NSLog(@"error = %@",[error localizedDescription]);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zixuns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXNewsViewCellID];
    cell.news = self.zixuns[indexPath.row];
    return cell;
    
}

- (void)back{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
    if ([self.webView canGoBack]) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImge:@"backImage_w" selectedIcon:@"backImage_w" target:self andSEL:@selector(back)];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    FXNews *news = self.zixuns[indexPath.row];
    FXWebViewController *webVC = [[FXWebViewController alloc]init];
    webVC.accessUrl = news.url;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
