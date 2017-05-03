//
//  WebViewController.m
//  +
//
//  Created by shensu on 17/3/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "WebViewXib.h"
#import "MBProgressHUD+MJ.h"
#import "SVProgressHUD.h"
@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong) WKWebView * webView;
@property(nonatomic,strong) UILabel * lable;
@property(nonatomic,strong) WebViewXib * footview;
@property(nonatomic,assign) BOOL isAddFoot;
@end

@implementation WebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.webView.navigationDelegate = self;
    self.lable.hidden = YES;
    
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD show];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
   [SVProgressHUD dismiss];
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.webView = [[WKWebView alloc]init];
    self.webView.UIDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self useProgressView];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 49, 0));
    }];


    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    self.lable.center = self.view.center;
    self.lable.font  = [UIFont systemFontOfSize:14];
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.textColor = [UIColor grayColor];
    self.lable.text = @"正在初始化配置信息";
    [self.view addSubview: self.lable];

    
    _footview = [[WebViewXib alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    [self.view addSubview:_footview];
    
    __weak __typeof (self) weak = self;
    _footview.WebViewBlock = ^(NSInteger tag){
        switch (tag) {
            case 1:
                if ([weak.webView canGoBack]){
                    [weak.webView goBack];
                }
                break;
            case 2:
                [weak.webView reload];
                
                break;
            case 3 :
                if ([weak.webView canGoForward]){
                    [weak.webView goForward];
                }
            default:
                [weak.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weak.url]]];
                break;
        }
    };
    // Do any additional setup after loading the view.
}


-(void)useProgressView
{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ( [keyPath isEqualToString:@"estimatedProgress"]){
        double leng = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSString * str = [NSString stringWithFormat:@"%.2f",leng*100];
       str = [str stringByAppendingString:@"%"];
        self.lable.text = [NSString stringWithFormat:@"正在初始化配置信息%@",str];
        if ([[change objectForKey:NSKeyValueChangeNewKey] doubleValue] == 1) {
            [UIView animateWithDuration:1 animations:^{
                [self.lable setAlpha:0];
            }];
            
        }
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:defa];
    [self presentViewController:alert animated:true completion:nil];
}

//web界面中有弹出确定框时调用
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(true);
    }];
    UIAlertAction * cancl = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    [alert addAction:defa];
    [alert addAction:cancl];
    [self presentViewController:alert animated:true completion:nil];

}
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
