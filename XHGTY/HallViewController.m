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
#import "MNXHViewController.h"
#define kItemMargin 2

typedef NS_ENUM(NSInteger, HallType){
    HallTypeXh        = 0,
    HallTypeKj     = 1,
    
};

@interface HallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *totalArr;
@property (nonatomic,strong) UISegmentedControl * segumented;
@property(nonatomic,assign) HallType tyoe;
@end

@implementation HallViewController

static NSString *const cellID = @"cellID";
-(void)setsegument{
//    NSArray * titleArray = @[@"选号",@"开奖"];
//    self.segumented = [[UISegmentedControl alloc]initWithItems:titleArray];
//    self.segumented.frame = CGRectMake(0, 0, 250, 40);
//    self.segumented.tintColor = [UIColor whiteColor];
//    self.segumented.selectedSegmentIndex = 0;
//    [self.segumented addTarget:self action:@selector(segumentedClick:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = self.segumented;
//    
    
    
    
}
-(void)segumentedClick:(UISegmentedControl *)segemert{
    switch (segemert.selectedSegmentIndex) {
        case 0:
            self.tyoe = HallTypeXh;
            break;
            
        default:
            self.tyoe = HallTypeKj;
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setsegument];
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

    if (self.tyoe == HallTypeXh){
        if (indexPath.row >0){
            NSDictionary * dic ;
            switch (indexPath.row) {
                case 0:
                    dic = @{@"dataArray":@[@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"}],@"nBlue":@"0",@"type":@"pc"};
                    break;
                case 1: case 2: case 4: case 5:
                    dic = @{@"dataArray":@[@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"},@{@"number":@"9",@"count":@"1"}],@"nBlue":@"4",@"type":@"pc",@"rule":@"任选5个号码，选中号与开奖开奖号码一致即中奖"};
                    break;
                case 3:
                    dic = @{@"dataArray":@[@{@"number":@"49",@"count":@"1"}],@"nBlue":@"0",@"type":@"pc",@"rule":@"任选1个号码，选中号与开奖开奖号码一致即中奖"};
                    break;
                case 6:
                    dic = @{@"dataArray":@[@{@"number":@"18",@"count":@"1"}],@"nBlue":@"0",@"type":@"pc",@"rule":@"任选1个号码，选中号与开奖开奖号码最后一位一致即中奖"};
                    break;
                case 7: case 8: case 9:
                    dic = @{@"dataArray":@[@{@"number":@"11",@"count":@"1"},@{@"number":@"11",@"count":@"1"},@{@"number":@"11",@"count":@"1"}],@"nBlue":@"0",@"type":@"pc",@"rule":@"至少选2个号码，选中号与开奖任意2位一致即中奖"};
                    break;
                case 10: case 11:
                    dic = @{@"dataArray":@[@{@"number":@"21",@"count":@"1"}],@"nBlue":@"0",@"type":@"pc",@"rule":@"任选1个号码，选中号与开奖开奖号码最后一位一致即中奖"};
                    break;
                default:
                    break;
            }
            
            MNXHViewController * vc = [[MNXHViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = kind.name;
            vc.dataDic = dic;
            vc.url = kind.url;
            [self.navigationController pushViewController:vc animated:YES];

        
        }else{
            GoucaiViewController * goucai = [[GoucaiViewController alloc]init];
            goucai.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goucai animated:YES];
        
        }
    }else{
    
            if (indexPath.row >0){
                CustonTableViewController *detailVC = [[CustonTableViewController alloc]init];
                detailVC.url = kind.url;
                detailVC.title = kind.name;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];

        
            }else{
  
        
                    PCDDTableViewController * vc = [[UIStoryboard storyboardWithName:@"Other" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PCDDTableViewController"];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
  
         
            }
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
