//
//  FXHomeMenuCycleView.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/23.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXHomeMenuCycleView.h"
#import "FXHomeMenuCycleCell.h"
#import "FXAd.h"
#import "AppDefine.h"

#define kCycleViewH kScreenW * 3 / 8

@interface FXHomeMenuCycleView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageContrl;

@property (nonatomic,strong)NSTimer *timer;
@end



@implementation FXHomeMenuCycleView

static NSString *const FXHomeMenuCycleCellID = @"FXHomeMenuCycleCell";

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FXHomeMenuCycleCell" bundle:nil] forCellWithReuseIdentifier:FXHomeMenuCycleCellID];
    
    kRegisterNotify(@"首页出现", @selector(timerContinue));
    kRegisterNotify(@"首页消失", @selector(timerPasue));
}

- (void)timerPasue{
    [self removeTimer];
}

- (void)timerContinue{
    [self addTimer];
}

+(instancetype)homeMenuCycleView {
    return [[[NSBundle mainBundle]loadNibNamed:@"FXHomeMenuCycleView" owner:nil options:nil]lastObject];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, -kCycleViewH, kScreenW, kCycleViewH);
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake(kScreenW, kCycleViewH);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalAds.count * 10000;
}

- (void)setTotalAds:(NSArray<FXAd *> *)totalAds{
    _totalAds = totalAds;
    self.pageContrl.numberOfPages = totalAds.count;
    
    
    [self.collectionView reloadData];
    
    //默认滚到中间某一个位置
    NSIndexPath *path = [NSIndexPath indexPathForRow:totalAds.count * 100 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    
    //添加定时器
    [self removeTimer];
    [self addTimer];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXHomeMenuCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXHomeMenuCycleCellID forIndexPath:indexPath];
    cell.imgName = self.totalAds[indexPath.item % self.totalAds.count].img;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(fxHomeMenuSelected:)]) {
        [self.delegate fxHomeMenuSelected:self.totalAds[indexPath.item % self.totalAds.count].url];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.totalAds){
     self.pageContrl.currentPage =  (NSInteger)(scrollView.contentOffset.x / kScreenW) % self.totalAds.count ;
    }
    
    
}


- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(repectClick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)repectClick{
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + kScreenW, 0) animated:YES];
    
}

- (void)removeTimer{
    [self.timer invalidate];
    
}


@end
