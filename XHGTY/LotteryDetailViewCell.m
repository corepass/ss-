//
//  LotteryDetailViewCell.m
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryDetailViewCell.h"
#import "LotteryDetailCollectionViewCell.h"
#import "LotteryKind.h"

@interface LotteryDetailViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation LotteryDetailViewCell
static NSString *  LotteryDetailCollectionViewCellID = @"LotteryDetailCollectionViewCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.showsVerticalScrollIndicator = false;
     [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryDetailCollectionViewCellID];
}

- (void)setTotalNum:(NSArray *)totalNum{
    _totalNum = totalNum;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    

    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = CGSizeMake(40 , 58);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalNum.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[collectionView dequeueReusableCellWithReuseIdentifier:LotteryDetailCollectionViewCellID forIndexPath:indexPath]);
    LotteryDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryDetailCollectionViewCellID forIndexPath:indexPath];
    
    cell.num = self.totalNum[indexPath.row];

   

//    if (self.blueNum) {
//        int lastNum = (int)(self.totalNum.count - self.blueNum);
//        
//        for (int index = lastNum -1; index < self.totalNum.count; index ++) {
//            [cell.lotteryBtn setBackgroundColor:[UIColor blueColor]];
//        }
//        
//    }
    
    return cell;
}


@end
