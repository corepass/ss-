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
#import "JXModel.h"
@interface ChossViewController ()
@property (nonatomic, strong) ChossMianView *chossMianView;
@end

@implementation ChossViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
  self.title =  @"注单";
 
    _chossMianView = [[ChossMianView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _chossMianView.chossTableView.dataArray = self.dataArray;
   
    [self.view addSubview:_chossMianView];
    __weak __typeof (self) weak = self;
  
    _chossMianView.deterButtonClickBlock = ^(NSString * cpNumber,NSString * sumMoney){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        dic[@"number"] = cpNumber;
        dic[@"sumMoney"] = sumMoney;
        if (weak.qishu){
          dic[@"qishu"] = weak.qishu;
        }else{
          dic[@"qishu"] = @"";
        }
        for (NSArray *countArray  in weak.dataArray) {
            for (NSArray *array  in countArray) {
                NSArray * classArray = [array copy];
                MNXHModel * model = classArray[0];
                model.number = cpNumber;
                dic[@"name"] = model.typeName;
                break;
            }
        }
     
        [weak upload:dic];
    
    };
    
    
    __weak typeof(self) weakSelf = self;
    _chossMianView.rootViwe.btnClick = ^(NSInteger index){
        
        if (index == 0 ) {
            [weakSelf OptionalChoss];
        }
        if (index == 1 ) {
            [weakSelf MachineSelectionChoss];
        }
        if (index == 2 ) {
            [weakSelf clearList];
        }
    };

}
- (void)OptionalChoss{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)MachineSelectionChoss{
    
    NSLog(@"机选一注");
      [self addView];
    NSArray * array  = [self setjxData];
    [self.dataArray addObject:array];
    _chossMianView.chossTableView.dataArray = self.dataArray;
    [_chossMianView.chossTableView reloadData];
  
    
}
- (void)clearList{
    
    NSLog(@"清空列表");
    
    [_chossMianView.chossTableView reloadData];
    [self clearView];
}
-(NSArray * )setjxData{
    JXModel *jxmodel = [[JXModel alloc] init];
    NSInteger Arcount = [_dic[@"dataArray"] count];
    
    int classCount = [_dic[@"dataArray"][0][@"count"] intValue];
    NSArray * array = [jxmodel getarc4randoArcount:(short)Arcount   classCount:classCount frome:01 tonumber:[_dic[@"dataArray"][0][@"number"] intValue]];


    NSMutableArray * slsArray = [[NSMutableArray alloc] init];
    for (int j = 0 ; j<array.count; j++) {
        NSMutableArray * lsArray = [[NSMutableArray alloc] init];
      
        for (int i = 0; i<[array[j] count]; i++) {
            MNXHModel * model = [[MNXHModel alloc]init];
            model.isSelected = false;
            model.typeName = self.titleName;
            model.number = [NSString stringWithFormat:@"%2@",array[j][i]];
       
            [lsArray addObject:model];
        }
        [slsArray addObject:lsArray];
    }
    
    return slsArray;

}
- (void)addView{
    
    _chossMianView.footView.determineButton.selected = NO;
    _chossMianView.footView.chossleftView.numberLable.text = [NSString stringWithFormat:@"%d",1];
    _chossMianView.footView.chossrightView.numberLable.text = [NSString stringWithFormat:@"%d",1];
    _chossMianView.footView.moneyLable.text = @"投注金额: 2 元";;
    
    
    NSString *str = _chossMianView.footView.moneyLable.text;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(5, _chossMianView.footView.moneyLable.text.length - 6);
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
    _chossMianView.footView.moneyLable.attributedText = attributedStr;
    _chossMianView.chossTableView.hidden = NO ;
    
}
- (void)clearView{
    if (self.removesuperBlock){
        self.removesuperBlock();
    }
    _chossMianView.chossTableView.hidden = YES ;
    _chossMianView.footView.chossleftView.numberLable.text = [NSString stringWithFormat:@"%d",0];
    _chossMianView.footView.chossrightView.numberLable.text = [NSString stringWithFormat:@"%d",0];
    _chossMianView.footView.moneyLable.text = @"投注金额: 0 元";;
    
    
    NSString *str = _chossMianView.footView.moneyLable.text;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(5, _chossMianView.footView.moneyLable.text.length - 6);
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
    _chossMianView.footView.moneyLable.attributedText = attributedStr;
    
    
    _chossMianView.footView.determineButton.selected = YES;
    [_dataArray removeAllObjects];
    _chossMianView.chossTableView.dataArray = self.dataArray;
    [_chossMianView.chossTableView reloadData];
    
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
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.c16000.com/bet/twpk10.html"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.c16000.com/bet/twpk10.html"]];
        }else{
                        ChoossFinishViewController * vc = [[ChoossFinishViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
        }
        
        [SVProgressHUD showWithStatus:@"保存成功"];
  
    }else{
      [SVProgressHUD showWithStatus:@"保存失败,请稍后再试！"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}



@end

