//
//  FDNewWeatherCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "FDNewWeatherCell.h"
#import "FDWeatherCollectionCell.h"
#import "FDChuanYiCollectioCell.h"
#import "FXWeather.h"


@interface FDNewWeatherCell()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIButton *weathLabel;
@property (weak, nonatomic) IBOutlet UILabel *shiduLabel;
@property (weak, nonatomic) IBOutlet UIButton *wuranLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *fengLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *weatherCollectionVIew;
@property (weak, nonatomic) IBOutlet UICollectionView *chuanyiCollectionView;

@end


@implementation FDNewWeatherCell


static NSString *FDWeatherCollectionCellID = @"FDWeatherCollectionCell";
static NSString *FDChuanYiCollectioCellID = @"FDChuanYiCollectioCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *weatherLayout = (UICollectionViewFlowLayout *)self.weatherCollectionVIew.collectionViewLayout;
    weatherLayout.itemSize = CGSizeMake((kScreenW - 10) / 5 , 130);
    
    UICollectionViewFlowLayout *chuanYiLayout = (UICollectionViewFlowLayout *)self.chuanyiCollectionView.collectionViewLayout;
    chuanYiLayout.itemSize = CGSizeMake((kScreenW - 10) /3, 35);
    
    
    [self.weatherCollectionVIew registerNib:[UINib nibWithNibName:@"FDWeatherCollectionCell" bundle:nil] forCellWithReuseIdentifier:FDWeatherCollectionCellID];
    [self.chuanyiCollectionView registerNib:[UINib nibWithNibName:@"FDChuanYiCollectioCell" bundle:nil] forCellWithReuseIdentifier:FDChuanYiCollectioCellID];
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return (collectionView == self.weatherCollectionVIew) ? 5 :6 ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.weatherCollectionVIew) {
        FDWeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FDWeatherCollectionCellID forIndexPath:indexPath];
        if (self.weathers.count) {
            cell.weekWeather = self.weathers[indexPath.item];
        }
        
        return cell;
    }
    
    FDChuanYiCollectioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FDChuanYiCollectioCellID forIndexPath:indexPath];
    if (self.chuanyis.count) {
       cell.chuanyiName = self.chuanyis[indexPath.item];
    }
    
    return cell;
}

- (void)setWeathers:(NSArray *)weathers{
    _weathers = weathers;
    [self.weatherCollectionVIew reloadData];
}

- (void)setChuanyis:(NSArray *)chuanyis{
    _chuanyis = chuanyis;
    [self.chuanyiCollectionView reloadData];
}

- (void)setWeather:(FXWeather *)weather{
    _weather = weather;
    
    
    self.tempLabel.text = [NSString stringWithFormat:@"%@º",weather.temperature ];
    
    self.shiduLabel.text = [NSString stringWithFormat:@"湿度:%@%%",weather.humidity];
    [self.weathLabel setImage:[UIImage imageNamed:weather.code] forState:UIControlStateNormal];
    [self.weathLabel setTitle:weather.info forState:UIControlStateNormal];
    self.fengLabel.text = [NSString stringWithFormat:@"%@风",weather.wind];
    self.jiLabel.text = [NSString stringWithFormat:@"%@级",weather.ji];
    [self.wuranLabel setTitle:weather.kongqi forState:UIControlStateNormal];
    self.cityLabel.text = weather.cityName;
    
//    if ([weather.kongqi hasPrefix:@"良"]) {
//        [self.wuranLabel setBackgroundColor:[UIColor colorWithRed:124/255.0 green:199/255.0 blue:139/255.0 alpha:1]];
//    }
    
    
}


@end
