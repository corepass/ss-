//
//  FXLotteryDistrCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXLotteryDistrCell.h"
#import "FXLotteryDIstrInfo.h"
#import "FXLotteryDistrInfoCell.h"
#import "AppDefine.h"

@interface FXLotteryDistrCell()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *qiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)NSMutableArray<NSString *> *totalBoards;

@end

@implementation FXLotteryDistrCell

static NSString *const FXLotteryDistrInfoCellID = @"FXLotteryDistrInfoCell";


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FXLotteryDistrInfoCell" bundle:nil] forCellWithReuseIdentifier:FXLotteryDistrInfoCellID];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    self.layout = layout;
    layout.minimumLineSpacing = 5;
}

- (void)setLotteryDistrinfo:(FXLotteryDIstrInfo *)lotteryDistrinfo{
    
    _lotteryDistrinfo = lotteryDistrinfo;
    
    self.qiLabel.text = [NSString stringWithFormat:@"第%@期",lotteryDistrinfo.expect];
    
    self.dateLabel.text = [NSString stringWithFormat:@"开奖时间:%@",lotteryDistrinfo.opentime];
    
    self.totalBoards = (NSMutableArray*)[lotteryDistrinfo.opencode componentsSeparatedByString:@","];
    
    NSString *lastStr = self.totalBoards.lastObject;
    
    if ([lastStr containsString:@"+"]) {
        NSArray *arr = [lastStr componentsSeparatedByString:@"+"];
        NSString *str1 = arr.firstObject;
        NSString *str2 = arr.lastObject;
        NSString *str3 = @"+";
        
        [self.totalBoards removeLastObject];
        [self.totalBoards addObject:str1];
        [self.totalBoards addObject:str3];
        [self.totalBoards addObject:str2];
    }
    
    int totalNum = (int)self.totalBoards.count;
    int totalMargin = (totalNum + 1) * 5 ;
    self.layout.itemSize = CGSizeMake((kScreenW-totalMargin) / totalNum, (totalNum >6)?40:50);
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalBoards.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXLotteryDistrInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXLotteryDistrInfoCellID forIndexPath:indexPath];
    cell.number = self.totalBoards[indexPath.item];
    if (self.totalBoards.count > 8) {
        cell.lotteryBtn.titleLabel.font = kFont(14);
    }
    return cell;
}

@end
