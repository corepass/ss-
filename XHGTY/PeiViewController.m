//
//  PeiViewController.m
//  +
//
//  Created by 杨健 on 2016/12/30.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "PeiViewController.h"
#import "PeiLvTableViewCell.h"
#import "HttpTools.h"
#import "FXPeiLv.h"
#import "MJExtension.h"
#import "UIBarButtonItem+Exstion.h"
#import "MJRefresh/MJRefresh.h"
#import "FXNewsViewCell.h"
#import "FXNews.h"
#import "FXWebViewController.h"
#import "SVProgressHUD.h"


@interface PeiViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property (nonatomic,strong)NSMutableArray *news;
@property (nonatomic,strong)NSMutableArray *peis;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

NSString *const PeiLvTableViewCellID = @"PeiLvTableViewCell";


@implementation PeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PeiLvTableViewCell" bundle:nil] forCellReuseIdentifier:PeiLvTableViewCellID];
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImge:@"refreshPic" selectedIcon:@"refreshPic" target:self andSEL:@selector(refresh)];
    
    self.title = @"娱乐";
    [self requestNews];
    self.tableView.hidden = NO;
    
//    self.webView.hidden = NO;
//    self.webView.delegate = self;
//    NSURL *url = [NSURL URLWithString:@"http://app.hg00fafa.com/"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
}


- (void)requestNews {
    
    [HttpTools getWithPath:@"http://odds.caipiao.163.com/interface/matchOddsInfo.html?gameEn=jczq&product=caipiao_client&mobileType=iphone&ver=4.29&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=B47090FF-A5D3-417C-87A0-EE52A67BB69E" parms:nil success:^(id JSON) {
        //
        self.peis = [FXPeiLv mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"matchOddsInfo"]];
        
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        NSLog(@"error = %@",[error localizedDescription]);
    }];
}

- (void)refresh{
    [self.webView reload];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}


- (void)refreshClick{
    [self.webView reload];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peis.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PeiLvTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PeiLvTableViewCellID];
    cell.peiLv = self.peis[indexPath.row];
    return cell;
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [SVProgressHUD dismiss];
//    if ([self.webView canGoBack]) {
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImge:@"backImage_w" selectedIcon:@"backImage_w" target:self andSEL:@selector(back)];
//    }else{
//        self.navigationItem.leftBarButtonItem = nil;
//    }
//}
//
//- (void)back{
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//    }
//}

//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    FXNews *news = self.news[indexPath.row];
//    FXWebViewController *webVC = [[FXWebViewController alloc]init];
//    webVC.accessUrl = news.url;
//    webVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webVC animated:YES];
//}


@end
