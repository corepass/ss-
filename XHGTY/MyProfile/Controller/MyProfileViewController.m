//
//  MyProfileViewController.m
//  YunGou
//
//  Created by x on 16/5/26.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyProfileTableViewCell.h"
#import "NSString+isEmpty.h"
#import "SVProgressHUD.h"
#import "XHGTY-swift.h"
//#import "ForgetViewController.h"
//#import "OCUtils.h"
//#import "ChangeNicknameViewController.h"
#import "MyProfileModel.h"

//#import "ChangPassWordViewController.h"
@interface MyProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic) NSMutableArray * DataArray;
@property(strong,nonatomic)  NSManagedObjectModel * model;
@property(strong,nonatomic)  NSMutableDictionary * infodic ;
@property(assign,nonatomic) BOOL hasMobile;
@property(copy,nonatomic) NSString* mobile;
@end

@implementation MyProfileViewController
-(void)getData{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"geojson"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _infodic = [NSMutableDictionary dictionaryWithDictionary:dic[@"member"]];
    [_MyProfileTableView reloadData];
   

}
-(UITableView *)MyProfileTableView
{
    if (!_MyProfileTableView) {
        _MyProfileTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _MyProfileTableView.delegate = self;
        _MyProfileTableView.dataSource = self;
        _MyProfileTableView.backgroundColor = [UIColor colorWithRed:0.9373 green:0.9373 blue:0.9373 alpha:1.0];
        [_MyProfileTableView setSeparatorColor:[[UIColor alloc]initWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1]];
        
    }
    return _MyProfileTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasMobile = false;
    
    self.title = @"我的资料";
   // _model = [[Application Main] userInfoModel];
    _TitleArray = [NSArray arrayWithObjects:
                   [NSArray arrayWithObjects:@"头像", nil],
                   [NSArray arrayWithObjects:@"ID",@"呢称",@"手机号",@"修改密码", nil],
                   [NSArray arrayWithObjects:@"推广码",@"推广二维码 （邀请好友赚返利)", nil],
                   nil];
  
    
    [self.view addSubview:self.MyProfileTableView];
     [self getData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_TitleArray[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _TitleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString * cellindetifi = @"cell";
    MyProfileTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellindetifi];
    MyProfileModel * ProfileModel = [[MyProfileModel alloc]init];
    if (!cell) {
        cell = [[MyProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellindetifi];
           }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 2 && indexPath.row == 1) {
        cell.TitleLable.attributedText = [self StringchangeAttributedString:_TitleArray[indexPath.section][indexPath.row]];
        [cell.UserImage.layer setCornerRadius:0];
    }else
    {
        cell.TitleLable.text=_TitleArray[indexPath.section][indexPath.row];
    }
    if ((indexPath.section == 2&&indexPath.row == 0)||(indexPath.section == 1&& (indexPath.row ==0 ||indexPath.row == 2))) {
        cell.RightImage.hidden=YES;
        
    }
  
    switch (indexPath.section) {
        case 0:
            ProfileModel.imageName = [_infodic objectForKey:@"face"];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    ProfileModel.subtitle = [_infodic objectForKey:@"memberId"];
                    break;
                case 1:
                    ProfileModel.subtitle = [_infodic objectForKey:@"nickname"] ;
                    break;
                case 2:
                    ProfileModel.subtitle = [_infodic objectForKey:@"mobile"];
                    if ([NSString isMobile:self.mobile]) {
                        ProfileModel.subtitle = self.mobile;
                    }
                    if ([NSString isMobile:ProfileModel.subtitle]) {
                        self.hasMobile = true;
                    }else{
                        cell.RightImage.hidden = NO;
                        ProfileModel.subtitle = @"请绑定手机号";
                        self.hasMobile = false;
                    }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                   ProfileModel.subtitle = [_infodic objectForKey:@"findCode"];
                    break;
                case 1:
                   ProfileModel.imageName = [_infodic objectForKey:@"qRCode"];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [cell indexcell:indexPath andmodel:ProfileModel];
    

    return  cell;

}
-(NSAttributedString *)StringchangeAttributedString:(NSString *)String
{NSMutableAttributedString * AttributedString = [[NSMutableAttributedString alloc]initWithString:String];
    NSDictionary * AttributedDic=@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
    [AttributedString addAttributes:AttributedDic range:NSMakeRange(6, 9)];
    
    return AttributedString;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self openphone];
            break;
            default:
            break;
    }

}
#pragma mark - 修改用户昵称代理
-(void)tochanggnickname:(NSString *)nickname;
{
    MyProfileTableViewCell * cell = [_MyProfileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    cell.SubtitleLable.text = nickname;
}
#pragma mark - 拍照／相册
-(void)openphone
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * photo =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            //指定调用资源为摄像头
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }];
    UIAlertAction * photoes =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  判断当前App是否可以使用相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            //指定picker调用资源为当前设备相册
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:photo];
    [alert addAction:photoes];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取照相拍摄的图片
    UIImage * images = [info valueForKey:UIImagePickerControllerOriginalImage];
    MyProfileTableViewCell * cell = [self.MyProfileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.UserImage.image = images;
    [[Apploction default] setUserImage:images];
    NSData *data = UIImageJPEGRepresentation(images, 0.5);
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * url = [path stringByAppendingString:@"/image.png"];
    [data writeToFile:url atomically:YES];
    [self uploadimage:[NSURL fileURLWithPath:url]];
    
    //将图片保存到相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(images, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadimage:(NSURL *)url
{
}

-(void) updateUserMobile:(NSString *)mobile{
    self.mobile = mobile;
    self.hasMobile = true;
    [self.MyProfileTableView reloadData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
