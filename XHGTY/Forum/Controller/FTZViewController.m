//
//  FTZViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FTZViewController.h"
// #import "FXUserTool.h"
//#import "FXAccount.h"
#import "MBProgressHUD+MJ.h"

@interface FTZViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTF;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;

@end

@implementation FTZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发帖子";
    

    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBlick)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    
}
- (void)rightBlick {
    if (!self.titleTF.text.length) {
        [FXTools showErrorMsg:@"请输入标题"];
        return;
    }else if (!self.contentTF.text.length){
        [FXTools showErrorMsg:@"请输入内容"];
        return;
    }
    
    FXAccount *account = [FXUserTool sharedFXUserTool].account;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"title"] = self.titleTF.text;
    dict[@"content"]= self.contentTF.text;
    dict[@"user_id"] = account.uid;
    
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:@"http://app.lh888888.com/Award/Api/userPost" parms:dict success:^(id JSON) {
        [MBProgressHUD showSuccess:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } :^(NSError *error) {
        //
    }];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    
    self.hiddenLabel.hidden = text.length;
    return YES;
}






@end
