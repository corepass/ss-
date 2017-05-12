//
//  CpMapViewController.m
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "CpMapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CpTableViewCell.h"
#import "CpDetaMapViewController.h"
@interface CpMapViewController ()<AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) AMapSearchAPI * seacher;
@property(strong,nonatomic) AMapLocationManager * locationManager;
@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic) NSMutableArray<AMapPOI *> * dataArray;
@property(strong,nonatomic) NSString * address;
@property(strong,nonatomic) CLLocation * location;
@property(strong,nonatomic) UILabel * lable;
@end

@implementation CpMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"彩票店";
    [self configLocationManager];
    _dataArray = [[NSMutableArray alloc] init];
    [self setUI];
    self.seacher = [[AMapSearchAPI alloc] init];
    self.seacher.delegate = self;

    
}
-(void)starSeacher:(CLLocation *) loc{
    CLLocationCoordinate2D  location = loc.coordinate;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:location.latitude longitude:location.longitude];
    request.keywords            = @"彩票店";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.seacher AMapPOIAroundSearch:request];


}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    for (AMapPOI * model  in response.pois) {
        [_dataArray addObject:model];
        NSLog(@"地址：%@ - 名称:%@ - location%@ - 图片:%@", model.address,model.name, model.location,model.images);
    }
    [self.tableView reloadData];
    //解析response获取POI信息，具体解析见 Demo
}

- (void)configLocationManager
{   [SVProgressHUD show];
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
       [SVProgressHUD dismiss];
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                [SVProgressHUD showErrorWithStatus:@"定位失败"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
        }
        self.location = location;
        [self starSeacher:location];

        
        if (regeocode)
        {

            self.address = [NSString stringWithFormat:@"%@%@%@",regeocode.city,regeocode.district,regeocode.POIName];
            
        }
        if (!self.address){
          
            [SVProgressHUD showErrorWithStatus:@"定位失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}
-(void)addTS{
    _lable = [[UILabel alloc] init];
    _lable.backgroundColor = [UIColor whiteColor];
    _lable.size = CGSizeMake(self.view.width, 30);
    _lable.center = self.tableView.center;
    _lable.text = @"您的附近暂无彩票店哦！";
    [_lable setTextAlignment:NSTextAlignmentCenter];
    _lable.font = [UIFont systemFontOfSize:14];
    [self.tableView addSubview:_lable];

}
-(void)setUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    [self.view addSubview:self.tableView];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count > indexPath.row){
        AMapPOI * model = _dataArray[indexPath.row];
        CpDetaMapViewController * vc = [[CpDetaMapViewController alloc] init];
        vc.poi = model;
        vc.location = self.location;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:14];
    if(self.address){
        NSString * string = [NSString stringWithFormat:@"您当前的位置是：%@",self.address];
        NSMutableAttributedString * mustr = [[NSMutableAttributedString alloc]initWithString:string];
        NSRange range = [string rangeOfString:self.address];
        [mustr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12] ,NSForegroundColorAttributeName:[[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1]} range:range];
        lable.attributedText = mustr;
    }else{
    lable.text = @"您当前的位置是：";
    }
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    return lable;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewAutomaticDimension;

}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * cellidentifi = @"cell";
    CpTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifi];
    if (cell == nil ){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CpTableViewCell" owner:self options:nil] firstObject];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count > indexPath.row){
        cell.poi = _dataArray[indexPath.row];
    }
    return  cell;
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
