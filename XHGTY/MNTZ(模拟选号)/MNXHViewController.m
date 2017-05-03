//
//  MNXHViewController.m
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNXHViewController.h"
#import "MNXHCollectionViewCell.h"
#import "MNheadCollectionReusableView.h"
#import "MNXHModel.h"
#import "MNXHFootView.h"
#import "JXModel.h"
#import "MNXHHeardView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ChossViewController.h"

static   NSString * cellidentifi = @"cell";
@interface MNXHViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionView * collectionView;
@property(strong,nonatomic) NSMutableArray<NSMutableArray *> * selArray;
@property(strong,nonatomic) MNXHFootView * footView;
@property(strong,nonatomic) JXModel * jxmodel;
@property(strong,nonatomic) MNXHHeardView * heard;
@property(strong,nonatomic) NSDictionary * hearddic;
@property(strong,nonatomic) NSString * qishu;
@end

@implementation MNXHViewController
-(void)getData{
   [HttpTools getCustonCAIPIAOWithPath:self.url parms:nil success:^(id JSON) {
       if ([JSON isKindOfClass:[NSArray class]]){
           _hearddic = [NSDictionary dictionaryWithDictionary:[JSON firstObject]];
           _qishu = [NSString stringWithFormat:@"%d",[_hearddic[@"expect"] intValue] + 1];
           _heard.qishu.text = [NSString stringWithFormat:@"第%d期",[_hearddic[@"expect"] intValue] + 1];
           _heard.openNumber.text = [NSString stringWithFormat:@"上期开奖结果:%@",_hearddic[@"opencode"]];
       }
   } :^(NSError *error) {
       _heard.qishu.text = @"期数获取异常";
   }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"摇一摇" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(35, 35);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    _heard = [[MNXHHeardView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 60)];
    _heard.rule.text = _dataDic[@"rule"];
    [self.view addSubview:_heard];
  
    [self.view bringSubviewToFront:_heard];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MNXHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellidentifi];
    [self.collectionView registerClass:[MNheadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heard"];
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    _footView = [[MNXHFootView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    __weak __typeof (self) weak = self;
    _footView.mnxhBtnBlcok = ^(){
        ChossViewController  * choss = [[ChossViewController alloc] init];
        choss.dataArray = [NSArray arrayWithArray: weak.selArray];
        choss.qishu = weak.qishu;
        [weak.navigationController pushViewController:choss animated:YES];
        
    };
    [self.view addSubview:_footView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(124, 0, 44, 0));
    }];
    
    // Do any additional setup after loading the view.
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self rightClick:self.navigationItem.rightBarButtonItem];
    }
    return;  
}
-(void)rightClick:(UIBarButtonItem *)sender{
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    _jxmodel = [[JXModel alloc] init];
    NSInteger Arcount = [_dataDic[@"dataArray"] count];
    
    int classCount = [_dataDic[@"dataArray"][0][@"count"] intValue];
    NSArray * array = [_jxmodel getarc4randoArcount:(short)Arcount   classCount:classCount frome:01 tonumber:[_dataDic[@"dataArray"][0][@"number"] intValue]];
    
    for (NSMutableArray * array in _selArray) {
        for (MNXHModel * model in array) {
            model.isSelected = NO;
        }
        [array removeAllObjects];
    }
    [self.collectionView reloadData];
    NSIndexPath * index ;
    for (int j = 0; j<array.count; j++) {
        for (int i= 0; i< [array[j] count]; i++) {
            index = [NSIndexPath indexPathForRow:[array[j][i] intValue] - 1 inSection:j];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:index];
        }
    }
    [self.collectionView reloadData];
    _footView.mnxhBtn.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    _footView.mnxhBtn.userInteractionEnabled = YES;

}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    NSArray * dataArray = dataDic[@"dataArray"];
    _selArray = [[NSMutableArray alloc] init];
    _nBlue = [dataDic[@"nBlue"] intValue];
    NSMutableArray * slsArray = [[NSMutableArray alloc] init];
    for (int j = 0 ; j<dataArray.count; j++) {
        NSMutableArray * lsArray = [[NSMutableArray alloc] init];
        int count = [dataArray[j][@"number"] intValue];
        for (int i = 0; i<count; i++) {
            MNXHModel * model = [[MNXHModel alloc]init];
            model.isSelected = false;
            model.typeName = self.title;
            model.number = [NSString stringWithFormat:@"%02d",i+1];
            if (j >= dataArray.count - _nBlue ){
                model.titleClor = [UIColor blueColor];
            }else{
                model.titleClor = [[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1];
            }
            [lsArray addObject:model];
        }
        [slsArray addObject:lsArray];
        [_selArray addObject:[[NSMutableArray alloc] init]];
    }
    
    _dataArray = slsArray;


}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        MNheadCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heard" forIndexPath:indexPath];
        if (_dataDic){
    view.titleLable.text = [NSString stringWithFormat:@"至少选择%@位",_dataDic[@"dataArray"][indexPath.section][@"count"]];
        }
 
        return view;
    
    }
    
    return nil;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.width, 50);

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MNXHCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellidentifi forIndexPath:indexPath];
    cell.numberLable.text = [NSString stringWithFormat:@"%02ld",indexPath.row + 1];
    cell.model = _dataArray[indexPath.section][indexPath.row];
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MNXHModel * model = _dataArray[indexPath.section][indexPath.row];
    model.isSelected = !model.isSelected;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    if(_selArray.count > indexPath.section){
        if(model.isSelected){
            [_selArray[indexPath.section] addObject:model];
        }else{
            [_selArray[indexPath.section] removeObject:model];
        }
    }
    NSInteger red = [_selArray.firstObject count];
    NSInteger blue = [_selArray.lastObject count];
    NSInteger sum ;
    if([_dataDic[@"type"] isEqualToString:@"ssq"] || [_dataDic[@"type"] isEqualToString:@"dlt"]){
        sum = [self red:red   blue:blue];
        if (sum >0){
            _footView.mnxhBtn.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
            _footView.mnxhBtn.userInteractionEnabled = YES;
        }else{
            _footView.mnxhBtn.backgroundColor = [UIColor grayColor];
            _footView.mnxhBtn.userInteractionEnabled = NO;
        }
        _footView.mnxhLable.text = [NSString stringWithFormat:@"已选%ld注",(long)sum];
    }else{
        sum = [self getsunmzhushu];
        if (sum >0){
            _footView.mnxhBtn.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
            _footView.mnxhBtn.userInteractionEnabled = YES;
        }else{
            _footView.mnxhBtn.backgroundColor = [UIColor grayColor];
            _footView.mnxhBtn.userInteractionEnabled = NO;
        }
        _footView.mnxhLable.text = [NSString stringWithFormat:@"已选%ld注",sum];
    }

}
-(NSInteger)getsunmzhushu{
    NSInteger sum = 1;
    for (int i = 0; i< [_dataDic[@"dataArray"] count]; i++) {
        if ([_dataDic[@"dataArray"][i][@"count"] integerValue]<= [_selArray[i] count]){
            sum *= [_selArray[i] count];
        }else{
            return 0;
        }
    }
    return sum;
}
-(NSInteger)red:(NSInteger)red blue:(NSInteger)blue
{
    //2*{N!/[(N-6)!*6!]}*K   双色球
    //  [self jiecheng:red]/([self jiecheng:red-6]*[self jiecheng:6]
    
    
// 大乐透  // [self jiecheng:red]/([self jiecheng:red-6]*[self jiecheng:6]*[self jiecheng:blue]/([self jiecheng:blue-2]*[self jiecheng:2]
    

    NSInteger sum =  ([self jiecheng:red]/([self jiecheng:red-6]*[self jiecheng:6])*blue);
    if (sum >= 0){
        return sum;
    }
    
    
    return 0;
}
-(NSInteger)jiecheng:(NSInteger)n{
    NSInteger sum = 1;
    for (int i = 1 ; i<=n ; i++) {
        sum *= i;
    }
    return sum;
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
