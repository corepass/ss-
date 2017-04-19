//
//  HallViewController.m
//  +
//
//  Created by 杨健 on 2016/12/30.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "HallViewController.h"
#import "FXHomeMenuCell.h"
#import "HttpTools.h"
#import "MJExtension.h"
#import "LotteryKind.h"
#import "LotteryDetailViewController.h"
#import "MJRefresh.h"
#import "GoucaiViewController.h"
#import "XHGTY-swift.h"
#import "LoginViewController.h"
#import "AppDefine.h"
#import "HallCollectionViewCell.h"
#define kItemMargin 2

@interface HallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *totalArr;
@end

@implementation HallViewController

static NSString *const cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = kGlobalColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
  
          [self.collectionView registerNib:[UINib nibWithNibName:@"HallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewImtes)];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemW = (kScreenW - 4 * kItemMargin) / 3;
    CGFloat itemH = itemW+5;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = kItemMargin;
    layout.minimumInteritemSpacing = kItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, kItemMargin, kItemMargin);
    
    [self.collectionView.mj_header beginRefreshing];
    
//    
//    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithTitle:@"试玩" style:UIBarButtonItemStyleDone target:self action:@selector(shiwan)];
//    barbutton.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = barbutton;
}
-(void)shiwan{
    GoucaiViewController * goucai = [[GoucaiViewController alloc]init];
    goucai.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goucai animated:YES];

}

- (void)loadNewImtes {

    NSString * path = [[NSBundle mainBundle] pathForResource:@"CaipiaoType" ofType:@"geojson"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.totalArr = [LotteryKind mj_objectArrayWithKeyValuesArray:dic[@"data"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.kind = self.totalArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   LotteryKind *kind = self.totalArr[indexPath.row];
    if (indexPath.row >0){
        CustonTableViewController *detailVC = [[CustonTableViewController alloc]init];
        detailVC.url = kind.url;
        detailVC.title = kind.name;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        
        
    }else{
        
//        if ( [Apploction default].isLogin){

            PCDDTableViewController * vc = [[UIStoryboard storyboardWithName:@"Other" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PCDDTableViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            LoginViewController * vc = [[UIStoryboard storyboardWithName:@"Other" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        
 
    }


}


//NSDate -----> NSString
- (NSString *)getFormatDateStringWithDate:(NSDate *)date  withFormatStyle:(NSString *)dateFormatStyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(NSString *)timeStrTotimestamp:(NSString*)timeStr withFormat:(NSString *)format{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //[inputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[inputDate timeIntervalSince1970]];
    return timeStamp;
}

@end
