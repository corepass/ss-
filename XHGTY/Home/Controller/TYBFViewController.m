//
//  TYBFViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/16.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "TYBFViewController.h"
#import "FXWebViewController.h"
#import "LHDQViewCell.h"
#import "FXLottery.h"
#import "FXHomeMenuCell.h"

#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
#define kItemMargin 2
#import "HallCollectionViewCell.h"
#import "BallTableViewController.h"
@interface TYBFViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray<FXLottery*> *totalArrs;
@end

@implementation TYBFViewController

static NSString *const cellID = @"cellID";

-(NSMutableArray<FXLottery*> *)totalArrs{
    if (_totalArrs == nil) {
        _totalArrs = [NSMutableArray array];
    }
    return _totalArrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"体育比分";
    
    
    NSArray *titles = @[@"足球比分",@"篮球比分"/*,@"体育直播"*/];
    NSArray *urls = @[@"http://live.159cai.com/live/jingcai?from=159cai",@"http://mlive.159cai.com/live/basketball?from=159cai"/*,@"http://www.wm007.com/forum.php?mod=forumdisplay&fid=2&mobile=2"*/];
    
    for (int index = 0; index < titles.count; index ++) {
        FXLottery *menu = [[FXLottery alloc]init];
        menu.label = titles[index];
        menu.href = urls[index];
        [self.totalArrs addObject:menu];
    }
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemW = (kScreenW - 4 * kItemMargin) / 3;
    CGFloat itemH = itemW+5;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = kItemMargin;
    layout.minimumInteritemSpacing = kItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, kItemMargin, kItemMargin);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalArrs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.lotteryName = self.totalArrs[indexPath.row].label;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * dic;
    switch (indexPath.row) {
        case 0:
            dic = @{@"open":@"http://api.datacenter.woying.com/soccer/score?lType=1&statType=2&issue=2017-04-19&sv2=1",@"unopen":@"http://api.datacenter.woying.com/soccer/score?lType=1&statType=1&issue=&sv2=1",@"title":@"足球"};
            break;
            
        default:
            dic = @{@"open":@"http://api.datacenter.woying.com/Basketball/score?lType=2&statType=2&issue=2017-04-19&sv2=1",@"unopen":@"http://api.datacenter.woying.com/Basketball/score?lType=2&statType=1&issue=&sv2=1",@"title":@"篮球"};
            break;
    }
    
    BallTableViewController * ball = [[BallTableViewController alloc]init];
    ball.hidesBottomBarWhenPushed = YES;
    ball.dic = dic;
    [self.navigationController pushViewController:ball animated:YES];
}


@end
