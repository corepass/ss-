//
//  HomeViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/17.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "HomeViewController.h"
#import "FXHomeMenuCell.h"
#import "FXHomeMenuCycleView.h"
#import "FXLottery.h"
#import "FXWebViewController.h"
#import "VideoDrawViewController.h"
#import "RecordViewController.h"
#import "LotteryDistrViewController.h"
#import "LHDQViewController.h"
#import "ThreeViewController.h"
#import "TieBieViewController.h"
#import "FXNoNetWorkView.h"
#import "FXAd.h"
#import "FXWebViewController.h"
#import "TYBFViewController.h"
#import "NotificationViewController.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
#import "GoucaiViewController.h"
#import "XHGTY-swift.h"
#import "HallCollectionViewCell.h"
#import "XYHeardView.h"
#import "ForumViewController.h"
#define kItemMargin 2
#import "CpMapViewController.h"
#import "HallCollectionViewCell.h"
/*
 足彩
 http://lhc.lh888888.com/Sports.aspx#
 
 */

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,requestNetWorDelegate,FXHomeMenuSelectedDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)FXHomeMenuCycleView *cycleView;

@property (nonatomic,strong)NSArray<FXLottery*> *totalLotters;

@property (nonatomic,strong)NSMutableArray *Ads;
/**网络链接失败*/
@property (nonatomic,strong)FXNoNetWorkView *nonetWorkView;
@end

@implementation HomeViewController

static NSString *const cellID = @"cellID";

-(NSMutableArray *)Ads{
    if (_Ads == nil) {
        _Ads = [NSMutableArray array];
    }
    return _Ads;
}


- (FXNoNetWorkView *)nonetWorkView{
    if (_nonetWorkView == nil) {
        _nonetWorkView = [FXNoNetWorkView noNetWorkView];
    }
    return _nonetWorkView;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    kSendNotify(@"首页消失", nil);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.totalLotters.count){
        kSendNotify(@"首页出现", nil);
    }
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Categories"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Message"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)leftClick{
    PCDDTableViewController * goucai = [[PCDDTableViewController alloc]init];
    goucai.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goucai animated:YES];
    
}
-(void)rightClick{
    NotificationViewController * noti = [[NotificationViewController alloc] init];
    noti.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:noti animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"大厅";
    self.nonetWorkView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[XYHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heard"];
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemW = (kScreenW - 4 * kItemMargin) / 3;
    CGFloat itemH = itemW+5;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = kItemMargin;
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 80);
    layout.minimumInteritemSpacing = kItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, kItemMargin, kItemMargin);
    
    [self loadNewItems];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //    if (self.totalLotters.count > indexPath.row){
    //        cell.iconImage.image = [UIImage imageNamed:self.totalLotters[indexPath.row].label];
    //        cell.titleLable.text = self.totalLotters[indexPath.row].label;
    //    }
    cell.lotteryName = self.totalLotters[indexPath.row].label;
    return cell;
}

- (void)requestNetWorkAgain{
    [self.nonetWorkView removeFromSuperview];
    [self loadNewItems];
}

- (void)loadNewItems{
    
    NSString * str = [[NSBundle mainBundle] pathForResource:@"HomeType" ofType:@"geojson"];
    NSDictionary * JSON = [NSDictionary dictionaryWithContentsOfFile:str];
    
    
    
    [self.nonetWorkView removeFromSuperview];
    self.totalLotters = [FXLottery mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
    
    [self.collectionView reloadData];
    
    self.Ads = [FXAd mj_objectArrayWithKeyValuesArray:JSON[@"ad"]];
    
    
    FXHomeMenuCycleView *cycleView = [FXHomeMenuCycleView homeMenuCycleView];
    cycleView.delegate = self;
    cycleView.totalAds =self.Ads;
    
    self.cycleView = cycleView;
    
    [self.collectionView addSubview:self.cycleView];
    self.collectionView.contentInset = UIEdgeInsetsMake(kScreenW * 3/8 , 0, 0, 0);
    
    
}

- (void)fxHomeMenuSelected:(NSString *)url{
    FXWebViewController *webVC = [[FXWebViewController alloc]init];
    webVC.accessUrl = url;
    if([url isEqualToString:@""]){
        return;
    }
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.titleName = @"活动";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalLotters.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XYHeardView * view;
    if (kind == UICollectionElementKindSectionHeader){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"heard" forIndexPath:indexPath];
        
        
    }
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FXLottery *lottery = self.totalLotters[indexPath.item];
    
    NSString *destStr = lottery.label;
    
    if ([destStr isEqualToString:@"体验中心"]) {
        //        FXWebViewController *webVC = [[FXWebViewController alloc]init];
        //        webVC.accessUrl = @"http://app.lhst6.com/shipinkaijiang/";
        //        webVC.titleName = @"视频开奖";
        //        webVC.hidesBottomBarWhenPushed = YES;
        ////        VideoDrawViewController *videoVC = [[VideoDrawViewController alloc]init];
        //        [self.navigationController pushViewController:webVC animated:YES];
        GoucaiViewController * goucai = [[GoucaiViewController alloc] init];
        goucai.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goucai animated:YES];
        return;
    }else if ([destStr isEqualToString:@"开奖记录"]){
        
        //        FXWebViewController *webVC = [[FXWebViewController alloc]init];
        //        webVC.accessUrl = @"http://app.lhst6.com/ziliao/shuju.php";
        //        webVC.titleName = @"开奖记录";
        //        webVC.hidesBottomBarWhenPushed = YES;
        ////        RecordViewController *recordVC = [[RecordViewController alloc]init];
        //        [self.navigationController pushViewController:webVC animated:YES];
        //        self.tabBarController.selectedIndex = 1;
        ForumViewController * vc = [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }else if ([destStr isEqualToString:@"彩票专区"]){
        LotteryDistrViewController *lotteryVC = [[LotteryDistrViewController alloc]init];
        lotteryVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lotteryVC animated:YES];
        return;
    }else if ([destStr isEqualToString:@"六合资料"]){
        LHDQViewController *lhVC = [[LHDQViewController alloc]init];
        lhVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lhVC animated:YES];
        return;
    }else if ([destStr isEqualToString:@"三期内必出"]){
        ThreeViewController *threeVC = [[ThreeViewController alloc]init];
        threeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:threeVC animated:YES];
        return;
    }else if ([destStr isEqualToString:@"特别号分析"]){
        TieBieViewController *tieBIEVC = [[TieBieViewController alloc]init];
        tieBIEVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tieBIEVC animated:YES];
        return;
    }else if ([destStr isEqualToString:@"体育比分"]){
        TYBFViewController *tieBIEVC = [[TYBFViewController alloc]init];
        tieBIEVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tieBIEVC animated:YES];
        return;
    }else if ([destStr isEqualToString:@"投注站"]){
//        PCDDTableViewController  *pcdd = [[UIStoryboard storyboardWithName:@"Other" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PCDDTableViewController"];
//        [self.navigationController pushViewController:pcdd animated:true];
        CpMapViewController * cp =  [[CpMapViewController alloc] init];
        cp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cp animated:YES];
    }else if ([destStr isEqualToString:@"彩票资讯"]){
        NewTableViewController * news = [[NewTableViewController alloc]init];
        news.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:news animated:true];
        
    }
    
}





@end
