//
//  RegisterView.m
//  YunGou
//
//  Created by x on 16/5/25.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "RegisterView.h"
#import "NSString+isEmpty.h"
#import "RegisterTableViewCell.h"
@interface RegisterView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString * Account;
    NSString * Captcha;
    NSString * Invitationsystem;
    NSString * SetupPassWord;
    NSString * ConfirmPassWord ;

}
@property(strong,nonatomic) UITableView * RegisterTableView;
@property(strong,nonatomic)  UIView * Footview;
@property(strong,nonatomic) UIButton * ChooseButton;
@property(strong,nonatomic) UILabel * AgreeLable;
@property(strong,nonatomic) UIButton * RegisterButton;
@property(strong,nonatomic) UILabel * ThirdLable;
@property(strong,nonatomic) UIImageView * QQImage;
@property(strong,nonatomic) UIImageView * WeiXinImage;
@property(strong,nonatomic) UILabel * CompanyLable;
@property(strong,nonatomic) NSMutableArray * DataArray;
@property(strong,nonatomic) UIButton * Button ;
@end
@implementation RegisterView
-(id)initWithFrame:(CGRect)frame andDataArray:(NSArray *)Array
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.RegisterTableView];
        _DataArray = [NSMutableArray arrayWithArray:Array];
    }

    return  self;
}
-(UITableView *)RegisterTableView
{
    if (!_RegisterTableView) {
        _RegisterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height+200) style:UITableViewStylePlain];
        _RegisterTableView.backgroundColor = [UIColor whiteColor];
        _RegisterTableView.showsVerticalScrollIndicator = NO;
        _RegisterTableView.delegate = self;
        _RegisterTableView.dataSource = self;
        _RegisterTableView.tableFooterView = self.Footview;
        _RegisterTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _RegisterTableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        _RegisterTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _RegisterTableView;
}
-(UIView *)Footview
{if(!_Footview){
    _Footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 320)];
    _Footview.backgroundColor = [UIColor whiteColor];

    [_Footview addSubview:self.RegisterButton];
//    [_Footview addSubview:self.ThirdLable];
//    [_Footview addSubview:self.QQImage];
//    [_Footview addSubview:self.WeiXinImage];

    self.AgreeLable.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AgreeLabletap)];
    [self.AgreeLable addGestureRecognizer:tap];
    
}
    return _Footview;
}
-(void)AgreeLabletap{
    if (self.aboutqmdb) {
        self.aboutqmdb();
    }

}
-(UIButton *)ChooseButton
{
    if (!_ChooseButton) {
        _ChooseButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, 14, 14)];
        [_ChooseButton setBackgroundImage:[UIImage imageNamed:@"Selected0"] forState:UIControlStateNormal];
        
    }
    return _ChooseButton;
}
-(UILabel *)AgreeLable
{
    if (!_AgreeLable) {
        _AgreeLable = [[UILabel alloc]initWithFrame:CGRectMake(49, 10, 250, 14)];
        [_AgreeLable setFont:[UIFont systemFontOfSize:13]];
        [_AgreeLable setTextColor:[UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1]];
        NSMutableAttributedString * AgreeLable = [[NSMutableAttributedString alloc]initWithString:@"我已同意 《全民夺宝服务协议》"];
        NSString * str  = @"我已同意 《全民夺宝服务协议》";
        NSRange rang = [str rangeOfString:@"我已同意 "];
        NSInteger loc = str.length - rang.length ;
        NSRange rang2 = NSMakeRange(rang.length, loc);
        [AgreeLable addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rang2];
        _AgreeLable.attributedText = AgreeLable;
    }
    return _AgreeLable;
    
}
-(UIButton *)RegisterButton
{   if(!_RegisterButton){
    _RegisterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_RegisterButton setFrame:CGRectMake(15, 50, self.frame.size.width-30, 44)];
    [_RegisterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 //   _RegisterButton.custom_acceptEventInterval = 5;
    [_RegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [_RegisterButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_RegisterButton.layer setCornerRadius:4];
    [_RegisterButton setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:52/255.0 blue:55.0/255.0 alpha:1.0]];
    [_RegisterButton addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
}
    
    return _RegisterButton;
}

-(UILabel *)ThirdLable
{
    if (!_ThirdLable) {
        _ThirdLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 106, self.frame.size.width-30, 14)];
        }
    
    return _ThirdLable;
}
-(UIImageView *)QQImage
{  if(!_QQImage){
    _QQImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-160)/2, 148, 50, 50)];
}
    
    return  _QQImage;
}
-(UIImageView *)WeiXinImage
{  if(!_WeiXinImage){
    _WeiXinImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-160)/2+80, 148, 50, 50)];

    
}
    
    return  _WeiXinImage;
}
-(void)loginqq
{
    if (_loginqqblock) {
        _loginqqblock(YES,NO);
    }

}
-(void)loginwx
{
    if (_loginqqblock) {
        _loginqqblock(NO,YES);
    }
}
-(UILabel *)CompanyLable
{
    if (!_CompanyLable) {
        _CompanyLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _Footview.frame.size.height-62, self.frame.size.width-30, 30)];
   
    }
    
    return _CompanyLable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_DataArray[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return  _DataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellindetifi = @"cell";
    RegisterTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellindetifi];
    if (!cell) {
        cell = [[RegisterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellindetifi];
           }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.RegisterTextFiled.delegate = self;
    if (indexPath.section == 0){
      cell.RegisterTextFiled.tag = indexPath.row;
        cell.RegisterTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else{
      cell.RegisterTextFiled.tag = indexPath.row+1;
        cell.RegisterTextFiled.keyboardType = UIKeyboardTypeDefault;
    }
    [cell.RegisterTextFiled addTarget:self action:@selector(TextFiledChang:) forControlEvents:UIControlEventEditingChanged];
    if(indexPath.row==1)
    {    _Button = cell.RegisterButton;
        [_Button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.section == 1) {
        cell.RegisterTextFiled.secureTextEntry = YES;
    }

    cell.Model = _DataArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)ButtonClick:(UIButton *)sender
{
    if([NSString isMobile:Account]){
      self.CaptchaBlock(Account,sender);
    }else
    {
        self.sendalertView(@"请输入正确的账号！");
    }
}
-(void)Register
{
    self.RegistBlock(Account,Captcha,Invitationsystem,SetupPassWord,ConfirmPassWord);
  
}
-(void)TextFiledChang:(UITextField *)sender
{
    NSLog(@"%ld and %@",(long)sender.tag, sender.text);
    switch (sender.tag) {
        case 0:
            if ([sender.text length]>11) {
                NSString * str = [sender.text substringWithRange:NSMakeRange(0, 11)];
                sender.text = str;
            }
            Account = sender.text;
            break;
        case 1:
            SetupPassWord = sender.text;
            break;
        case 2:
            ConfirmPassWord = sender.text;
            break;
        default:
            break;
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
          
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }

    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

 [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
