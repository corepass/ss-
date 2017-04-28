//
//  TieBieViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/9.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "TieBieViewController.h"
#import "UIImage+GIF.h"
#import "YFRollingLabel.h"
#import "TieBieViewCell.h"

#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
#import "JXModel.h"
@interface TieBieViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) YFRollingLabel *totalPersonsLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *qiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)NSMutableArray *numbers;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@end

@implementation TieBieViewController


static NSString *const TieBieViewCellID = @"TieBieViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"特别号分析";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TieBieViewCell" bundle:nil] forCellWithReuseIdentifier:TieBieViewCellID];
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithName:@"分享" target:self andSEL:@selector(btnclick)];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(50, 50);
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.layout = layout;
    
    [self loadNewItems];
}



- (void)loadNewItems{
 
    
    [HttpTools getWithPath:kTieBie parms:nil success:^(id JSON) {
        //
        
     //   NSDictionary *dict = JSON[@"content"];
        
        
        self.qiLabel.text = @"系统分析特别号为:";
        
//        NSString *num = dict[@"post_content"];
        JXModel * jx = [[JXModel alloc] init];
        jx.cpCount = 3;
        NSArray *arr = [jx getarc4random];
        
        self.numbers = (NSMutableArray *)arr;
        
       self.layout.itemSize = CGSizeMake(30, 30);
        
        
        
    } :^(NSError *error) {
        //
    }];
    
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numbers.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TieBieViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TieBieViewCellID forIndexPath:indexPath];
    if (self.numbers.count) {
        cell.number = self.numbers[indexPath.row];
    }
    return cell;
}


- (IBAction)btnAction:(UIButton *)sender {
    sender.enabled = NO;

    
    [self.numbers removeAllObjects];
    [self.collectionView reloadData];
    
    [self loadNewItems];
    
    [self gifPlay6];
    
    [self addLabel];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        self.gifImageView.image = [UIImage imageNamed:@"saima.jpg"];
        [self.totalPersonsLabel removeFromSuperview];
        self.startBtn.enabled = YES;
    });
}


/**   *  利用SDWebImageView 库播放gif   *  Memory-22.6M   *  #import "UIImage+GIF.h"   */
-(void)gifPlay6  {
    UIImage  *image=[UIImage sd_animatedGIFNamed:@"xindian@2x"];
    self.gifImageView.image=image;
}


- (void)addLabel{
    NSArray *textArray = @[@"系统正在分析",@"系统正在分析",@"系统正在分析"];
    
    self.totalPersonsLabel = [[YFRollingLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gifImageView.frame)-40, kScreenW, 40)  textArray:textArray font:kFont(15) textColor:[UIColor whiteColor]];
    [self.view addSubview:self.totalPersonsLabel];
    
    self.totalPersonsLabel.speed = 5;
    [self.totalPersonsLabel setOrientation:RollingOrientationRight];
    [self.totalPersonsLabel setInternalWidth:0];;
}



@end
