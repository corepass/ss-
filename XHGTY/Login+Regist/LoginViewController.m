//
//  LoginViewController.m
//  YunGou
//
//  Created by x on 16/5/23.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "LoginViewController.h"

#import "XHGTY-swift.h"
#import "RegisterViewController.h"
#import "NSString+isEmpty.h"
#import "SVProgressHUD.h"
#import "HttpTools.h"
#import "MBProgressHUD+MJ.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *UserBackVew;
//账号
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFIeld;
@property (weak, nonatomic) IBOutlet UIView *PassWordBackView;
//密码
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *ForgetPassWord;
//登录
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
//注册
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
//qq
@property (weak, nonatomic) IBOutlet UIImageView *QQImage;
//微信
@property (weak, nonatomic) IBOutlet UIImageView *WeiXinImage;


@end

@implementation LoginViewController
//忘记密码按钮事件
- (IBAction)ForgetButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"toForget" sender:self];
}
//登录按钮事件
- (IBAction)LoginButtonClick:(id)sender {
    NSUserDefaults  *defa = [NSUserDefaults standardUserDefaults];
    [HttpTools postWithPath:@"Award/Api/login" parms:@{@"name":self.PhoneTextFIeld.text,@"password":self.PassWordTextField.text} success:^(id JSON) {
        if ([JSON[@"status"]intValue] == 2) {
            [MBProgressHUD showError:JSON[@"info"]];
            [self.view endEditing:YES];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Apploction default].isLogin = YES;
            [defa setValue:self.PhoneTextFIeld.text forKey:@"account"];
            [defa setValue:self.PassWordTextField.text forKey:@"password"];
            
            FXAccount *account = [[FXAccount alloc]init];
            account.uid = JSON[@"id"];
            account.userName = JSON[@"user_nicename"];
            account.avatar = JSON[@"avatar"];
            [[FXUserTool sharedFXUserTool]saveAccount:account];
         //   [MBProgressHUD showSuccess:@"登录成功"];
          //  kSendNotify(@"登录成功", nil);
            
            
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    } :^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"帐号或密码错误"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
        
    }];
//    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:@"http://app.lh888888.com/Award/Api/login" parms:@{@"name":self.userNameTF.text,@"password":self.passwordTF.text} success:^(id JSON) {
//        if ([JSON[@"status"]intValue] == 2) {
//            [MBProgressHUD showError:JSON[@"info"]];
//            [self.view endEditing:YES];
//            return ;
//        }
//        
//        
//        FXAccount *account = [[FXAccount alloc]init];
//        account.uid = JSON[@"id"];
//        account.userName = JSON[@"user_nicename"];
//        account.avatar = JSON[@"avatar"];
//        [[FXUserTool sharedFXUserTool]saveAccount:account];
//        [MBProgressHUD showSuccess:@"登录成功"];
//        kSendNotify(@"登录成功", nil);
//        
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } :^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"帐号或密码错误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//    }];
//    
//
//    NSUserDefaults  *defa = [NSUserDefaults standardUserDefaults];
//    if([NSString isMobile:self.PhoneTextFIeld.text] && [self.PhoneTextFIeld.text  isEqual: @"13166118659"] && [self.PassWordTextField.text isEqualToString:@"123456"]){
//        [SVProgressHUD show];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            [Apploction default].isLogin = YES;
//            [defa setValue:self.PhoneTextFIeld.text forKey:@"account"];
//            [defa setValue:self.PassWordTextField.text forKey:@"password"];
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//
//    }else if ([NSString isMobile:self.PhoneTextFIeld.text] && [self.PhoneTextFIeld.text  isEqual: [defa valueForKey:@"account"]] && [self.PassWordTextField.text isEqualToString:[defa valueForKey:@"password"]]){
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            [Apploction default].isLogin = YES;
//            [defa setValue:self.PhoneTextFIeld.text forKey:@"account"];
//            [defa setValue:self.PassWordTextField.text forKey:@"password"];
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//
//    }
//    else{
//        [SVProgressHUD showErrorWithStatus:@"帐号或密码错误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
// 
//    }
//    
}
//注册按钮事件
- (IBAction)RegisterButtonClick:(id)sender {
     RegisterViewController * vc = [[RegisterViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
//微信登录
- (void)weixin_tap:(id)sender
{
 
}
//QQ登录
- (void)QQ_tap:(id)sender
{

  
}



//设置控件
-(void)load
{
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    [self.UserBackVew.layer setCornerRadius:4];
    [self.UserBackVew.layer setBorderColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];
    [self.UserBackVew.layer setBorderWidth:1.0f];
    
    [self.PassWordBackView.layer setCornerRadius:4];
    [self.PassWordBackView.layer setBorderColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];
    [self.PassWordBackView.layer setBorderWidth:1.0f];
    
    [self.LoginButton.layer setCornerRadius:4];
    [self.RegisterButton.layer setCornerRadius:4];
    [self.RegisterButton.layer setBorderWidth:1.0f];
    [self.RegisterButton.layer setBorderColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];
    
    [self.ForgetPassWord setTitleColor:[UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    NSMutableAttributedString * ForgetText = [[NSMutableAttributedString alloc]initWithString:@"忘记密码？"];
    NSRange range ={0,[ForgetText length]};
    [ForgetText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [self.ForgetPassWord setAttributedTitle:ForgetText forState:UIControlStateNormal];
    
    [self.LoginButton setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:52/255.0 blue:55.0/255.0 alpha:1.0]];
 //   [self.RegisterButton setTitleColor:[UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    UITapGestureRecognizer * QQ_tap = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(QQ_tap:)];
    self.QQImage.userInteractionEnabled = YES;
    [self.QQImage addGestureRecognizer:QQ_tap];
    UITapGestureRecognizer * weixin_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weixin_tap:)];
     self.WeiXinImage.userInteractionEnabled = YES;
    [self.WeiXinImage addGestureRecognizer:weixin_tap];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"登录"];
    
    
    
    [self load];
    
    self.PhoneTextFIeld.delegate=self;
    self.PassWordTextField.delegate=self;
    self.PhoneTextFIeld.keyboardType = UIKeyboardTypeNumberPad;
    [self.PhoneTextFIeld addTarget:self action:@selector(textchang:) forControlEvents:UIControlEventEditingChanged];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillshow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillhide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)textchang:(UITextField *)sender
{
    if ([sender.text length]>11) {
        NSString * str = [sender.text substringWithRange:NSMakeRange(0, 11)];
        sender.text = str;
    }

}
-(void)keyboardwillshow:(NSNotification *)sender
{
    //
 // CGRect keyBoardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

   // [self.view setFrame:CGRectMake(0, -keyBoardFrame.size.height, self.view.size.width, self.view.size.height)];
}
-(void)keyboardwillhide:(NSNotification *)sender
{
//  CGRect keyBoardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

  //    [self.view setFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
