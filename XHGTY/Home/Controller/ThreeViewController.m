//
//  ThreeViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ThreeViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "SVProgressHUD.h"

@interface ThreeViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"三期内必出";
    
    [self loadNewItems];
}

- (void)loadNewItems{
    
    [HttpTools postWithPath:kLHDQThree parms:nil success:^(id JSON) {
        
        NSString *htmlData = JSON[@"data"];
        
        [self.webView loadHTMLString:htmlData baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        
    } :^(NSError *error) {
        //
    }];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

@end
