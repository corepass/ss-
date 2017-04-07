//
//  LHDQViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "LHDQViewController.h"
#import "LHDQMenu.h"
#import "FXLotteryDistrCell.h"
#import "LHDQViewCell.h"
#import "ArticleListViewController.h"
#import "FXWebViewController.h"
#import "HttpTools.h"
#import "AppDefine.h"
#import "MJExtension.h"
#import "AppURLdefine.h"

//判断设备宽高
#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH ([[UIScreen mainScreen] bounds].size.height)
@interface LHDQViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *menus;
@end

@implementation LHDQViewController

static NSString *const LHDQViewCellID = @"LHDQViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"六合资料";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LHDQViewCell" bundle:nil] forCellWithReuseIdentifier:LHDQViewCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemW = (kScreenW - 20)/3 ;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    [self loadNewItems];
}

- (void)loadNewItems{
    [HttpTools getWithPath:kLHDQMenu parms:nil success:^(id JSON) {
        
        FxLog(@"JSON = %@",JSON);
        self.menus = [LHDQMenu mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        [self.collectionView reloadData];
        
    } :^(NSError *error) {
        //
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menus.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHDQViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LHDQViewCellID forIndexPath:indexPath];
    cell.menu = self.menus[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LHDQMenu *meun = self.menus[indexPath.item];
    
    FXWebViewController *webVC = [[FXWebViewController alloc]init];
    webVC.titleName = meun.content;
    webVC.accessUrl = meun.url;
    [self.navigationController pushViewController:webVC animated:YES];
//    
//    
//    ArticleListViewController *articleVC = [[ArticleListViewController alloc]init];
//    articleVC.articleID = meun.ID;
//    articleVC.title = meun.content;
//    [self.navigationController pushViewController:articleVC animated:YES];
}

@end
