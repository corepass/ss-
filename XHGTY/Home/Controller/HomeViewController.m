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
#import "LotteryDistrViewController.h"
#import "LHDQViewController.h"
#import "ThreeViewController.h"
#import "TieBieViewController.h"
#import "FXNoNetWorkView.h"
#import "FXAd.h"
#import "FXWebViewController.h"
#import "TYBFViewController.h"

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
#define kItemMargin 5
#import "CpMapViewController.h"
#import "HallCollectionViewCell.h"
#import "LoginViewController.h"
#import "DHGuidePageHUD.h"
#import "WebViewController.h"
#import "JXModel.h"
#import "AppModel.h"
#import "FXNLViewController.h"
#import "FXViewController.h"
#import "HomegpcCollectionViewCell.h"
#import "gpcModel.h"
#import "SSXHViewController.h"
#import "MessageRuntime.h"
#import "StylesViewController.h"
#import "ZhuanjiaTableViewController.h"
#import "FXHomeTableViewController.h"
/*
 足彩
 http://lhc.lh888888.com/Sports.aspx#
 
 */

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,requestNetWorDelegate,FXHomeMenuSelectedDelegate,UIAlertViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)FXHomeMenuCycleView *cycleView;

@property (nonatomic,strong)NSArray<FXLottery*> *totalLotters;

@property(nonatomic,strong) NSMutableArray<FXLottery*> * section0Array;

@property (nonatomic,strong)NSMutableArray *Ads;
/**网络链接失败*/
@property (nonatomic,strong)FXNoNetWorkView *nonetWorkView;

@property(nonatomic,strong) NSMutableArray<gpcModel *> * gpcArray;
@end

@implementation HomeViewController

static NSString *const cellID = @"cellID";
static NSString *const gpcID = @"gpcID";
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

    NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
    if ([defa valueForKey:@"account"]){
        [SVProgressHUD showWithStatus:@"您已经登录了！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        LoginViewController * login = [[UIStoryboard storyboardWithName:@"Other" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    
    }

}
-(void)rightClick{
  
    FXViewController * noti = [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"FXViewController"];
    noti.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:noti animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
   
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    _section0Array = [[NSMutableArray alloc] init];
     _gpcArray = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = app_Name;
    self.nonetWorkView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomegpcCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:gpcID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[XYHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heard"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
  

    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
           [self setBannar];
   //        [self getgpcData];
    }];
    [self loadNewItems];
    
 //   [self getgpcData];
    [self setBannar];
}

-(void)getgpcData{
   [HttpTools GETWithPath:@"http://news.zhuoyicp.com/h5/gp/json.json" parms:nil success:^(id JSON){
       if (JSON != nil){
        
           _gpcArray = [gpcModel mj_objectArrayWithKeyValuesArray:JSON];
           NSLog(@"******************%lu*************************",(unsigned long)_gpcArray.count);
           dispatch_async(dispatch_get_main_queue(), ^{
                 [self.collectionView reloadData];
           });
         
       }
   } :^(NSError *error) {
       
   }];

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake( self.collectionView.frame.size.width/3, 80);
            break;
        case 1:
        {
            CGFloat itemW = (kScreenW - 4 * kItemMargin) / 3;
            CGFloat itemH = itemW+5;
      
            return CGSizeMake(itemW, itemH);
        }
            break;
            
        default:
            return CGSizeMake(self.view.width, 100);
            break;
    }

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
if (section == 0)
{
    return  UIEdgeInsetsMake(kItemMargin, 0, 0, 0);
}
    return UIEdgeInsetsMake(kItemMargin, kItemMargin, kItemMargin, kItemMargin);

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return CGSizeMake(self.view.frame.size.width , 80);
            break;
            
        default:
            return CGSizeZero;
            break;
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0){
        return 0;
    }
    return kItemMargin;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0){
        return 0;
    }
    return kItemMargin;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_gpcArray.count == 0){
        return 2;
    }
    return  3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return self.totalLotters.count;
            break;
            
        default:
            return _gpcArray.count > 3 ? 3 : 0;
            break;
    }

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
            
        case 0:
        {
            HallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
            
            cell.lotteryName = self.section0Array[indexPath.row].label;
            return cell;
        }
            break;
        case 1:
        {
            HallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
            
            cell.lotteryName = self.totalLotters[indexPath.row].label;
            return cell;
        }
            break;
            
        default:
        {
            HomegpcCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gpcID forIndexPath:indexPath];

                cell.model = _gpcArray[indexPath.row];
  
            return cell;
        }
            break;
    }
    

}

- (void)requestNetWorkAgain{
    [self.nonetWorkView removeFromSuperview];
    [self loadNewItems];
}
-(void)setBannar{

                    NSString * str = [[NSBundle mainBundle] pathForResource:@"HomeType" ofType:@"geojson"];
                    NSDictionary * JSON = [NSDictionary dictionaryWithContentsOfFile:str];
                    self.Ads = [FXAd mj_objectArrayWithKeyValuesArray:JSON[@"ad"]];
                    _cycleView.totalAds =self.Ads;
                
                
                


}
- (void)loadNewItems{
    
    NSArray * array = @[@{@"label":@"专家"},@{@"label":@"分析"},@{@"label":@"走势"}];
    self.section0Array = [FXLottery mj_objectArrayWithKeyValuesArray:array];
    NSString * str = [[NSBundle mainBundle] pathForResource:@"HomeType" ofType:@"geojson"];
    NSDictionary * JSON = [NSDictionary dictionaryWithContentsOfFile:str];
    
    
    
    [self.nonetWorkView removeFromSuperview];
    self.totalLotters = [FXLottery mj_objectArrayWithKeyValuesArray:JSON[@"content"]];
    
    [self.collectionView reloadData];
    
   
    
    
    _cycleView = [FXHomeMenuCycleView homeMenuCycleView];
    _cycleView.delegate = self;
  //  _cycleView.totalAds =self.Ads;
    
    self.cycleView = _cycleView;
    
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



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XYHeardView * view;
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 0){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"heard" forIndexPath:indexPath];
        
    }
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                 ZhuanjiaTableViewController * vc = [[ZhuanjiaTableViewController alloc]     init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.title = @"专家";
                    [self.navigationController pushViewController:vc animated:true];
                }
                    break;
               case 1:
                {
                    FXHomeTableViewController * vc = [[FXHomeTableViewController alloc]     init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.title = @"分析";
                    [self.navigationController pushViewController:vc animated:true];
                }

                    break;
                default:
                {
                    FXWebViewController * vc = [[FXWebViewController alloc]     init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.titleName = @"走势";
                    vc.accessUrl = @"http://client.310win.com/aspx/ChartList.aspx?_t=1495090318.014192";
                    [self.navigationController pushViewController:vc animated:true];
                }
                    break;
            }
        
        }
            break;
        case 1:
        {
            FXLottery *lottery = self.totalLotters[indexPath.item];
            
            NSString *destStr = lottery.label;
            
            if ([destStr isEqualToString:@"走势图"]) {

                StylesViewController * style = [[StylesViewController alloc] init];
                style.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:style animated:YES];
                
//                FXViewController * noti = [[UIStoryboard storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"FXViewController"];
//                noti.hidesBottomBarWhenPushed = true;
//                [self.navigationController pushViewController:noti animated:YES];
                return;
            }else if ([destStr isEqualToString:@"彩票论坛"]){
                
      
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

                CpMapViewController * cp =  [[CpMapViewController alloc] init];
                cp.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cp animated:YES];
            }else if ([destStr isEqualToString:@"彩票资讯"]){
       
                
                FXWebViewController * web = [[FXWebViewController alloc] init];
           
                web.titleName = @"彩票资讯";
                web.accessUrl = @"http://news.soa.woying.com/";
                web.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:web animated:YES];
            }
        }
            break;
            
        default:
        {
            gpcModel * model = _gpcArray[indexPath.row];
            FXWebViewController * web =[[FXWebViewController alloc]init];
            web.titleName = model.title;
            web.accessUrl = model.contentUrl;
            web.hidesBottomBarWhenPushed = YES;
            web.isneed = YES;
            [self.navigationController pushViewController:web animated:YES];
            

        }
            break;
    }
    
}



@end
