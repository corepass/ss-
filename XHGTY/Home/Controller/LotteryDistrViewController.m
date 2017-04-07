//
//  LotteryDistrViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "LotteryDistrViewController.h"
#import "LotteryDistrViewCell.h"
#import "FXLotteryDistr.h"
#import "LotteryDistrInfoViewController.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"

@interface LotteryDistrViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *totalLotterys;

@end

@implementation LotteryDistrViewController

static NSString *const LotteryDistrViewCellID = @"LotteryDistrViewCell";

- (NSMutableArray *)totalLotterys{
    if (_totalLotterys == nil) {
        _totalLotterys = [NSMutableArray array];
    }
    return _totalLotterys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"彩票专区";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryDistrViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryDistrViewCellID];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    layout.itemSize = CGSizeMake((kScreenW - 40)/3, 40);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    [self loadNewItems];
}


- (void)loadNewItems{
    [HttpTools getWithPath:kLotteryDistr parms:nil success:^(id JSON) {
        //
        self.totalLotterys = [FXLotteryDistr mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
        [self.collectionView reloadData];
        
    } :^(NSError *error) {
        //
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalLotterys.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LotteryDistrViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryDistrViewCellID forIndexPath:indexPath];
    cell.lotteryDist = self.totalLotterys[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FXLotteryDistr *lotteryStr = self.totalLotterys[indexPath.item];
    LotteryDistrInfoViewController *infoVC = [[LotteryDistrInfoViewController alloc]init];
    infoVC.navigationItem.title = lotteryStr.alias;
    infoVC.requestURL = lotteryStr.api_url;
    [self.navigationController pushViewController:infoVC animated:YES];
}


@end
