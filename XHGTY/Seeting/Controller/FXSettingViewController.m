//
//  FXSettingViewController.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXSettingViewController.h"
#import "FeedbackViewContoller.h"
#import "LoginViewController.h"
@interface FXSettingViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *bottomCell;
@end

@implementation FXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kAccount.uid) {
        self.bottomCell.hidden = NO;
    }
}

- (IBAction)loginOutAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10086;
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 10086) {
        if (buttonIndex == 1) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:kAccountFile error:nil];
            kAccount.uid = nil;
            self.bottomCell.hidden = YES;
            
            NSUserDefaults * user  = [NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:@"account"];
            [user removeObjectForKey:@"password"];
          
            LoginViewController * login = [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:login animated:YES];
            
           
        }
    }
    
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        [SVProgressHUD showInfoWithStatus:@"清除缓存成功"];
    }else if (indexPath.row == 4) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E9%87%8D%E5%BA%86%E6%97%B6%E6%97%B6%E5%BD%A9-%E5%BC%80%E5%A5%96%E5%8A%A9%E6%89%8B/id1218691138?mt=8"]];
    }else if (indexPath.row == 1){
        FeedbackViewContoller * vc = [[FeedbackViewContoller alloc] init];
        [self.navigationController pushViewController:vc  animated:YES];
    }
}


@end
