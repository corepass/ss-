//
//  RecordViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "RecordViewCell.h"
#import "RecordOneViewCell.h"
#import "RecordAddViewCell.h"
#import "FXRecord.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
@interface RecordViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RecordViewCell

static NSString *const RecordOneViewCellID = @"RecordOneViewCell";
static NSString *const RecordAddViewCellID = @"RecordAddViewCell";


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordOneViewCell" bundle:nil] forCellWithReuseIdentifier:RecordOneViewCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake((kScreenW)/8, 70);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordAddViewCell" bundle:nil] forCellWithReuseIdentifier:RecordAddViewCellID];
    
}

- (void)setRecord:(FXRecord *)record{
    _record = record;
    
    self.recordLabel.text = [NSString stringWithFormat:@"第%@期,开奖日期:%@",record.shortperiod,record.longdate];
    [self.collectionView reloadData];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 6) {
        RecordAddViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecordAddViewCellID forIndexPath:indexPath];
        return cell;
    }
    RecordOneViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecordOneViewCellID forIndexPath:indexPath];
    cell.board = self.record.totalBords[indexPath.item];
    return cell;
}

@end
