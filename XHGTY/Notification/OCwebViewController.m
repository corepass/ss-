//
//  OCwebViewController.m
//  bjscpk10
//
//  Created by shensu on 17/3/27.
//  Copyright © 2017年 shensu. All rights reserved.
//

#import "OCwebViewController.h"

@interface OCwebViewController ()

@end

@implementation OCwebViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Image-3"] style:UIBarButtonItemStyleDone target:self action:@selector(goBackClock)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    
    
}
-(void)goBackClock{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * web = [[UIWebView alloc]initWithFrame:self.view.frame];
    [web loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:web];
    // Do any additional setup after loading the view.
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
