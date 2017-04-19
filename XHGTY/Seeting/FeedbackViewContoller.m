//
//  FeedbackViewContoller.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/21.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FeedbackViewContoller.h"

@interface FeedbackViewContoller ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation FeedbackViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
  
    self.navigationItem.title = @"意见反馈";

    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    
}


- (void)submitAction{
    [self.view endEditing:YES];
    
    if (!self.textView.text.length) {
        [MBProgressHUD showError:@"请填写反馈内容"];
        return;
    }
    
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://app.lh888888.com/Award/Forum/feedback" parms:@{@"user_id":kAccount.uid,@"content":self.textView.text} success:^(id JSON) {
        [MBProgressHUD showSuccess:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } :^(NSError *error) {
        //
    }];
    

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    self.tipsLabel.hidden = text.length;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
