//
//  ChossViewController.m
//  +
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ChossViewController.h"
#import "ChossMianView.h"
#import "MNXHModel.h"
#import "ChoossFinishViewController.h"
@interface ChossViewController ()

@end

@implementation ChossViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title =  @"注单";
 
    ChossMianView *chossMianView = [[ChossMianView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    chossMianView.chossTableView.dataArray = self.dataArray;
   
    [self.view addSubview:chossMianView];
    __weak __typeof (self) weak = self;
  
    chossMianView.deterButtonClickBlock = ^(NSString * cpNumber,NSString * sumMoney){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        dic[@"number"] = cpNumber;
        dic[@"sumMoney"] = sumMoney;
        if (self.qishu){
          dic[@"qishu"] = self.qishu;
        }else{
          dic[@"qishu"] = @"";
        }
        
        for (NSArray *array  in self.dataArray) {
            NSArray * classArray = [array copy];
            MNXHModel * model = classArray[0];
            model.number = cpNumber;
            dic[@"name"] = model.typeName;
            break;
        }
        [weak upload:dic];
    
    };
}

-(void)upload:(NSDictionary * )dic{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]stringByAppendingFormat:@"/Caches"];
    NSString * file = [NSString stringWithFormat:@"%@/caipiao.data",path];
    NSMutableArray * array ;
    if([NSMutableArray arrayWithContentsOfFile:file]){
    array = [NSMutableArray arrayWithContentsOfFile:file];
    }else{
        array = [[NSMutableArray alloc] init];
    }
   
    [array addObject:dic];
    if ([array writeToFile:file atomically:YES]){
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
//            ChoossFinishViewController * vc = [[ChoossFinishViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        });
        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.c16000.com/bet/twpk10.html"]]){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.c16000.com/bet/twpk10.html"]];
//        }else{
                        ChoossFinishViewController * vc = [[ChoossFinishViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
//        }
//        
        [SVProgressHUD showWithStatus:@"保存成功"];
  
    }else{
      [SVProgressHUD showWithStatus:@"保存失败,请稍后再试！"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}



@end

