//
//  XZViewController.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/28.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "XZViewController.h"
#import "UIBarButtonItem+Exstion.h"

#define xingzuos @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座",@"射手座", @"魔蝎座", @"水瓶座", @"双鱼座"]
#define chinesexingzuos @[@"aries", @"taurus", @"gemini", @"cancer", @"leo", @"virgo", @"libra", @"scorpio",@"sagittarius", @"capricorn", @"aquarius", @"pisces"]

@interface XZViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activView;
@end

@implementation XZViewController{
    UIToolbar *_toolBar;
    UIPickerView *_pickView;
    UIView *_coverView;
    NSString *_selectedStr;
    UIButton *_titleBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 40);
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [btn setTitle:xingzuos[self.selectNum] forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    _titleBtn = btn;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImge:@"cancel" selectedIcon:@"cancel" target:self andSEL:@selector(dismiss)];
    
    NSString *requestURL = [NSString stringWithFormat:@"http://app.lh888888.com/%@",self.requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    
    [self.webView loadRequest:request];
    
    self.webView.hidden = YES;
    
    [self.activView startAnimating];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImge:@"backImage_w" selectedIcon:@"backImage_w" target:self andSEL:@selector(cancelClick)];
}


- (void)cancelClick{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 网页视图加载完毕会调用代理的这个方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *str = @"document.getElementsByClassName('wnlBannerLink dayViewWnlLink')[0].remove();";
    [self.webView stringByEvaluatingJavaScriptFromString:str];
    
    self.webView.hidden = NO;
    self.activView.hidden = YES;
}


- (void)btnClick{
    [self addPickView];
}

- (void)addPickView{
    
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 244, kScreenW, kScreenH - 64)];
    _coverView.backgroundColor = [UIColor lightGrayColor];
    _coverView.alpha = 0.5;
    [self.view addSubview:_coverView];
    
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 140)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.dataSource = self;
    pickView.delegate = self;
    
    if (_selectedStr) {
       NSInteger row = [chinesexingzuos indexOfObject:_selectedStr];
        [pickView selectRow:row inComponent:0 animated:NO];
    }
    
    
    [self.view addSubview:pickView];
    _pickView = pickView;
    
    [self createToolBar];
    _titleBtn.enabled = NO;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 12;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = xingzuos[row];
    
    //NSLog(@"str = %@",str);
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _selectedStr = chinesexingzuos[row];
    
}


#pragma mark - 添加ToolBar
-(void)createToolBar{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,204 , kScreenW, 40)];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    lefttem.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    right.tintColor = [UIColor blackColor];
    
    toolbar.items=@[lefttem,centerSpace,right];
    [self.view addSubview:toolbar];
    _toolBar = toolbar;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)doneClick{
    [_pickView removeFromSuperview];
    [_toolBar removeFromSuperview];
    [_coverView removeFromSuperview];
    _titleBtn.enabled = YES;
    _titleBtn.selected = NO;
    
    NSString *str = [NSString stringWithFormat:@"http://h5.jp.51wnl.com/wnl/xz/view?astro=%@",_selectedStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [self.webView loadRequest:request];
    
    NSInteger index = [chinesexingzuos indexOfObject:_selectedStr];
    
    
    [_titleBtn setTitle:xingzuos[index] forState:UIControlStateNormal];
}

- (void)cancel{
    [_pickView removeFromSuperview];
    [_toolBar removeFromSuperview];
    [_coverView removeFromSuperview];
    _titleBtn.enabled = YES;
    _titleBtn.selected = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    if ([[error localizedDescription]containsString:@"互联网"]) {
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"提示" message:[error localizedDescription] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
    }
    
}


@end
