//
//  ForumInfoViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ForumInfoViewController.h"
#import "FXforum.h"
#import "LoginViewController.h"
#import "FXNavigationController.h"

@interface ForumInfoViewController ()<UIScrollViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *replayView;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;

@end

@implementation ForumInfoViewController{
    UIToolbar *_toolBar;
    BOOL iscancel;
    CGFloat _offsetY;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self doneClick];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([self.forum.user_id isEqualToString:kAccount.uid]) {
        self.replayView.hidden = YES;
    }else if (!self.iscollection) {
     
        
        UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"收藏"style:UIBarButtonItemStyleDone target:self action:@selector(saveItems)];
        right.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = right;
    }
    
    if (!kAccount.uid) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"论坛详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //添加键盘弹出的通知
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.forum.avatar]];
    
    
    self.name.text = self.forum.user_nicename;
    self.time.text = self.forum.add_time;
    self.content.text = self.forum.content;
    self.titleLabel.text = [NSString stringWithFormat:@"  %@",self.forum.title];
    
}

//收藏帖子
- (void)saveItems{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"forum_id"] = self.forum.ID;
    dict[@"user_id"] = kAccount.uid;
    
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://app.lh888888.com/Award/Forum/collect/" parms:dict success:^(id JSON) {
        if ([JSON[@"status"]intValue] == 2) {
            [MBProgressHUD showSuccess:JSON[@"info"]];
            return ;
        }
        [MBProgressHUD showSuccess:@"收藏成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    } :^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription]];
    }];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self createToolBar];
    
    self.bottomCons.constant = 315+ 40;
    [self.view setNeedsLayout];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}
- (IBAction)submitAction:(id)sender {
    if (!self.commentTV.text.length) {
        [FXTools showErrorMsg:@"请填写回复内容"];
        return;
    }else{
        [self doneClick];
        if (!kAccount.uid) {
            LoginViewController *loginVC =  [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];;
    
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }
    }
    
    
    [self.view endEditing:YES];
    [_toolBar removeFromSuperview];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = kAccount.uid;
    dict[@"forum_id"]=@"37";
    dict[@"content"]=self.commentTV.text;
    
    
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://app.lh888888.com/Award/Forum/reply" parms:dict success:^(id JSON) {
        [MBProgressHUD showSuccess:@"回复成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } :^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription]];
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - 添加ToolBar
-(void)createToolBar{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,kScreenH-317-40+64, kScreenW, 40)];
    [toolbar setBarTintColor:[UIColor lightGrayColor]];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    lefttem.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    right.tintColor = [UIColor blackColor];
    
    toolbar.items=@[lefttem,centerSpace,right];
    [kAppWindow addSubview:toolbar];
    _toolBar = toolbar;
}


- (void)doneClick{
    [self.view endEditing:YES];
    [_toolBar removeFromSuperview];
    self.bottomCons.constant = 8;
    [self.view layoutIfNeeded];
    
}




@end
