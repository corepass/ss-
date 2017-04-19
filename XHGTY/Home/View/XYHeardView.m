//
//  XYHeardView.m
//  +
//
//  Created by shensu on 17/4/11.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "XYHeardView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "AppDefine.h"
#import "HttpTools.h"
#import "JXModel.h"
static NSMutableArray * lableArray = nil;
static NSArray * nArray = nil;
static NSString * qishu = @"";
static NSString * kjtime = @"";
static JXModel * jx = nil;
@implementation XYHeardView
-(void)getqishu{
 [HttpTools getCustonCAIPIAOWithPath:@"http://f.apiplus.cn/ssq-5.json" parms:nil success:^(id JSON) {
     if(JSON){
         qishu = JSON[0][@"expect"];
         kjtime = [self  tranfromTime:[JSON[0][@"opentimestamp"] longLongValue]];
     }
 } :^(NSError *error) {
     
 }];

}
-(NSString *)tranfromTime:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts/1000.0];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
-(void)reloadArray{
      nArray = [jx getarc4random];
    for (int i = 0;i < 7 ; i++) {
        UILabel * lable = lableArray[i];
        [self transition:lable];
        lable.text = nArray[i];
    }

}
-(void)saveBtnClick{
    NSDictionary * dic = @{@"time":[self xianzaishijian],@"haoma":nArray,@"qishu":qishu,@"kjtime":kjtime};
    if ( ![self savadata:dic]) {
        [SVProgressHUD showErrorWithStatus:@"已经收藏了"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
   
}
-(NSString *)xianzaishijian{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
  //  NSDate *date = [formatter dateFromString:dateTime];
    return dateTime;
}
-(BOOL)savadata:(NSDictionary * )dic{
    
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]stringByAppendingFormat:@"/Caches"];
    NSString * file = [NSString stringWithFormat:@"%@/userAccount.shouchang",path];
    NSMutableArray * array = [NSMutableArray arrayWithContentsOfFile:file];
    if (array == nil) {
        array = [[NSMutableArray alloc] init];
    }
    for (NSDictionary * savedic in array) {
        if([savedic[@"time"] isEqualToString: dic[@"time"]]){
            return NO;
        }
    }
    [array addObject:dic];

    [array writeToFile:file atomically:YES];
    
    return YES;
}

-(void)transition:(UILabel *)manImageView{
    //创建一个CGAffineTransform  transform对象
    UIViewAnimationOptions option =  UIViewAnimationOptionTransitionFlipFromLeft;
  
    [UIView transitionWithView:manImageView
                      duration:0.5f
                       options:option
                    animations:^ {

                    }
                    completion:^ (BOOL finished){
                   
                    }];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self getqishu];
      jx = [[JXModel alloc] init];
        jx.cpCount = 6;
        jx.isblue = YES;
      self.backgroundColor = kGlobalColor;
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
        self.typeLable = [[UILabel alloc]init];
        self.typeLable.text = @"双色球";
        self.typeLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.typeLable];
        
        UILabel * lable  = [[UILabel alloc]init];
        lable.text = @"福地惊喜2元中720万元大奖！";
        lable.font = [UIFont systemFontOfSize:12];
        lable.textColor = [UIColor grayColor];
        [self addSubview:lable];
        
        UIButton * change = [UIButton buttonWithType:UIButtonTypeSystem];
        [change setTitle:@"换一注" forState:UIControlStateNormal];
        [change setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        change.titleLabel.font = [UIFont systemFontOfSize:12];
        [change addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:change];
       
        self.addSaveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.addSaveBtn setTitle:@"立即收藏" forState:UIControlStateNormal];
        [self.addSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addSaveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.addSaveBtn setBackgroundColor:[[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1]];
        [self.addSaveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addSaveBtn];
        
        [self.typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
//            make.height.mas_offset(20);
            make.width.mas_offset(60);
            make.top.mas_equalTo(self).offset(15);
        }];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.typeLable.mas_right).offset(5);
//            make.height.mas_offset(20);
            make.width.mas_offset(170);
            make.top.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self.typeLable);
        }];
        
        [change mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_offset(20);
            make.width.mas_offset(60);
            make.top.mas_equalTo(self).offset(15);
        }];
        
        [self.addSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_offset(30);
            make.width.mas_offset(70);
            make.bottom.mas_equalTo(self).offset(-5);
        }];
        
        nArray = [NSArray arrayWithArray:[jx getarc4random]];
        lableArray = [[NSMutableArray alloc] init];
        for (int i = 0;i < 7 ; i++) {
            UILabel * lable = [[UILabel alloc]init];
            lable.text = nArray[i];
            lable.layer.cornerRadius = 12.5;
            [lable setTextAlignment:NSTextAlignmentCenter];
            lable.layer.borderWidth = 1;
            if (i == 6){
              lable.layer.borderColor = [[UIColor alloc] initWithRed:20/255.0 green:114/255.0 blue:214/255.0 alpha:1].CGColor;
            }else{
             lable.layer.borderColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1].CGColor;
            }
           
            lable.font = [UIFont systemFontOfSize:12];
            [self addSubview:lable];
            [lableArray addObject:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                if(i == 0){
                    make.left.mas_equalTo(self).offset(15);
                }else{
                    UILabel * lable = lableArray[i-1];
                    make.left.mas_equalTo(lable.mas_right).offset(5);
                }
                make.top.mas_equalTo(self.typeLable.mas_bottom).offset(5);
                make.bottom.mas_equalTo(self).offset(-5);
                make.size.mas_offset(CGSizeMake(25, 25));
            }];
            
        }
        
   
    }
    return self;
}
-(void)changeClick{
    [self reloadArray];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
