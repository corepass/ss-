//
//  GoucaiViewController.m
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "GoucaiViewController.h"
#import "CollectionViewCell.h"
#import "AppDefine.h"
#import "GouCaiModel.h"
#import "MJExtension.h"
#import "GouMaiView.h"
#import "GoucaiTableViewController.h"
#import "SVProgressHUD.h"
#import "HttpTools.h"
static NSString * cellindetifi = @"cell";
@interface GoucaiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property(strong,nonatomic)UICollectionView * collection;
@property(strong,nonatomic) NSArray * dataArray;
@property(strong,nonatomic)  GouMaiView * footView;

@end

@implementation GoucaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];

    self.title = self.titlename;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3 - 20, 70);
    _collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    _collection.backgroundColor = kGlobalColor;
    [_collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellindetifi];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.scrollEnabled = YES;
    [self.view addSubview:_collection];
    _footView = [[GouMaiView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    _footView.textField.delegate = self;
    __weak __typeof (self) weak = self;
    _footView.buyBtnClickBlcok = ^(){
        NSMutableArray * array = [[NSMutableArray alloc] init];
        for (GouCaiModel * model  in weak.dataArray) {
            if(model.isSelected){
                [array addObject:model];
            }
        }
        if(array.count != 0){
            GoucaiTableViewController * goucai = [[GoucaiTableViewController alloc] init];
            goucai.dataArray = array;
            goucai.number = weak.footView.textField.text;
            goucai.title = [NSString stringWithFormat:@"第%@期",weak.qishu];
            [weak.navigationController pushViewController:goucai animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请选择你要下注号码"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        
        }
    };
    _footView.textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willhide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)getdata{
    [SVProgressHUD show];
    
           NSArray * array = @[@{@"type":@"大",@"peilv":@"赔率：1.98",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"单",@"peilv":@"赔率：1.98",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"大单",@"peilv":@"赔率：3",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"大双",@"peilv":@"赔率：3",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"极大",@"peilv":@"赔率：10",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"小",@"peilv":@"赔率：1.98",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"双",@"peilv":@"赔率：1.98",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"小单",@"peilv":@"赔率：1.98",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"小双",@"peilv":@"赔率：3",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename},
                               @{@"type":@"极小",@"peilv":@"赔率：10",@"isSelected":@"0",@"qishu":self.qishu,@"name":self.titlename}];
           
           _dataArray = [GouCaiModel mj_objectArrayWithKeyValuesArray:array];
           [self.collection reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length > 5){
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)willshow:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.5 animations:^{
     _footView.frame = CGRectMake(0, self.view.frame.size.height - 50 - rect.size.height, self.view.frame.size.width, 50);
    }];


}
-(void)willhide:(NSNotification *)noti {
   [UIView animateWithDuration:0.5 animations:^{
          _footView.frame = CGRectMake(0, self.view.frame.size.height - 50 , self.view.frame.size.width, 50);
   }];

}
-(void)dealloc{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellindetifi forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    GouCaiModel * model = _dataArray[indexPath.row];
    model.isSelected = !model.isSelected;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    for (GouCaiModel * model in _dataArray) {
        if(model.isSelected){
            [_footView.buyBtn setBackgroundColor:[[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1]];
            return ;
        }else{
            [_footView.buyBtn setBackgroundColor:[UIColor lightGrayColor]];
           
        }
    }
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
