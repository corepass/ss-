//
//  RegisterViewController.m
//  YunGou
//
//  Created by x on 16/5/24.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "RegusterCellModel.h"
#import "RegisterView.h"
#import "RegisterModel.h"
#import "RegusterCellModel.h"
#import "RegisterModel.h"
#import "ThirdLoginModel.h"
#import "NSString+isEmpty.h"
#import "SVProgressHUD.h"
#import "NSString+isEmpty.h"
#import "SVProgressHUD.h"
#import "HttpTools.h"
#import "MBProgressHUD+MJ.h"
@interface RegisterViewController ()
@property(strong,nonatomic) NSMutableArray * Array;
@property(strong,nonatomic) ThirdLoginModel * Model;
@property(strong,nonatomic) NSMutableArray * DataArray;
@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _Model  = [[ThirdLoginModel alloc]init];
    self.title = @"注册";
    
    
    _Array = [[NSMutableArray alloc] init];
    NSArray * TitleArray = @[@[@"account"],@[@"password",@"password"]];
    
    NSArray * PlaceholderArray = @[@[@"请输入手机号"],@[@"密码为6~12位字符",@"请确认登录密码"]];
    for (int i = 0 ;i<TitleArray.count ; i++) {
        _DataArray = [[NSMutableArray alloc] init];
        for ( int j = 0; j<[TitleArray[i] count]; j++) {
            RegusterCellModel * model = [[RegusterCellModel alloc]init];
            model.Title = TitleArray[i][j] ;
            model.placeholder=PlaceholderArray[i][j];
            [_DataArray addObject:model];
        }
        [_Array addObject:_DataArray];
    }

    RegisterView * Regist =[[RegisterView alloc]initWithFrame:self.view.bounds andDataArray:_Array];
    [self.view addSubview:Regist];
    Regist.aboutqmdb = ^(){
  
    };
    
    Regist.RegistBlock = ^(NSString * Account,NSString * Captcha,NSString * Invitationsystem,NSString * SetupPassWord,NSString * ConfirmPassWord)
    {
        
        [HttpTools postWithPath:@"Award/Api/register" parms:@{@"name":Account , @"password" : SetupPassWord,@"repassword":ConfirmPassWord} success:^(id JSON) {
            if ([JSON[@"status"]intValue] == 2) {
                
                [MBProgressHUD showError:JSON[@"info"]];
                return ;
            }else{
                [SVProgressHUD showWithStatus:@"注册成功"];
                NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
                [defa setValue:Account forKey:@"account"];
                [defa setValue:SetupPassWord forKey:@"password"];
                [defa synchronize];
                [self.navigationController popToRootViewControllerAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [SVProgressHUD dismiss];
                });
              
            }
            
            
        } :^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的格式"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
    };
    Regist.CaptchaBlock = ^(NSString *Account,UIButton * sender){
        NSLog(@"点击了获取验证码按钮并有值返回Account:%@",Account);
  
    };
    
    Regist.sendalertView = ^(NSString * title){
        
        [SVProgressHUD showErrorWithStatus:title];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });

    };

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
