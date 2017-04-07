//
//  RecordInfoViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "RecordInfoViewController.h"
#import "NALLabelsMatrix.h"
#import "FXRecord.h"
#import "SingleViewCell.h"
#import "FXBoard.h"
#import "RecordAddViewCell.h"
#import "RecordOneViewCell.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"

@interface RecordInfoViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *BoardcollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *infoCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *topqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *topDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleTotalLabel;
@property (nonatomic,strong)NSMutableArray *totalBoards;
@property (nonatomic,strong)NSMutableArray *totalinfos;
@end

@implementation RecordInfoViewController

static NSString *const RecordOneViewCellID = @"RecordOneViewCell";
static NSString *const RecordAddViewCellID = @"RecordAddViewCell";
static NSString *const SingleViewCellID = @"SingleViewCell";
- (NSMutableArray *)totalBoards{
    if (_totalBoards == nil) {
        _totalBoards = [NSMutableArray array];
    }
    return _totalBoards;
}

- (NSMutableArray *)totalinfos{
    if (_totalinfos == nil) {
        _totalinfos = [NSMutableArray array];
    }
    return _totalinfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开奖详情";
    
    
    [self.BoardcollectionView registerNib:[UINib nibWithNibName:@"RecordOneViewCell" bundle:nil] forCellWithReuseIdentifier:RecordOneViewCellID];
    [self.BoardcollectionView registerNib:[UINib nibWithNibName:@"RecordAddViewCell" bundle:nil] forCellWithReuseIdentifier:RecordAddViewCellID];
    
    [self.infoCollectionView registerNib:[UINib nibWithNibName:@"SingleViewCell" bundle:nil] forCellWithReuseIdentifier:SingleViewCellID];
    
    UICollectionViewFlowLayout *boardLayout = (UICollectionViewFlowLayout *)self.BoardcollectionView.collectionViewLayout;
    boardLayout.itemSize = CGSizeMake(kScreenW/8, 70);
    
    UICollectionViewFlowLayout *infoLayout = (UICollectionViewFlowLayout *)self.infoCollectionView.collectionViewLayout;
    infoLayout.itemSize = CGSizeMake((kScreenW - 10)/3, 30);
    infoLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    [self loadNewItems];
}


- (void)loadNewItems{
    
    [HttpTools postWithPath:KRecordInfo parms:@{@"year":self.oneRecord.longdate,@"period":self.oneRecord.shortperiod} success:^(id JSON) {
        //
        NSDictionary *dict = JSON[@"content"];
        
        NSDictionary *infoDict = JSON[@"contentinfo"];
        
        self.topqiLabel.text = [NSString stringWithFormat:@"%@期开奖详情",dict[@"shortperiod"]];
        self.topDateLabel.text = [NSString stringWithFormat:@"开奖日期:%@",dict[@"longdate"]];
        
        self.middleTotalLabel.text = [NSString stringWithFormat:@"总和单双：(%@)%@%@",infoDict[@"zonghe"],infoDict[@"zonghedaxiao1bijiao"],infoDict[@"zonghedanshuang"]];
        NSString *sxStr = infoDict[@"num7shengxiao"];
        NSString *dsStr = infoDict[@"num7danshuang"];
        NSString *bosStr = infoDict[@"num7bose"];
        NSString *daxStr = infoDict[@"num7daxiao"];
        NSString *wuxStr = infoDict[@"num7wuxing"];
        NSString *tetStr = infoDict[@"num7tounum"];
        NSString *wsStr = infoDict[@"num7weinum"];
        NSString *hsdtr = infoDict[@"num7heshudanshuang"];
        NSString *jyStr = infoDict[@"num7jiaye"];
        NSString *msStr = infoDict[@"num7menshu"];
        NSString *dwStr = infoDict[@"num7duanwei"];
        NSString *yyStr = infoDict[@"num7yinyang"];
        NSString *tdStr = infoDict[@"num7tiandi"];
        NSString *jxStr = infoDict[@"num7jixiong"];
        NSString *hbStr = infoDict[@"num7heibai"];
        NSString *shexStr = infoDict[@"num7sexiao"];
        NSString *bhStr = infoDict[@"num7bihua"];
        NSString *nvStr = infoDict[@"num7nannv"];
        
        NSArray *arr = @[@"生肖:",@"单双:",@"波色:",@"大小:",@"五行:",@"特头:",@"尾数:",@"合单双:",@"家野:",@"门数:",@"段位:",@"阴阳:",@"天地:",@"吉凶:",@"黑白:",@"生肖:",@"笔画:",@"男女:"];
        NSArray *infoArr = @[sxStr,dsStr,bosStr,daxStr,wuxStr,tetStr,wsStr,hsdtr,jyStr,msStr,dwStr,yyStr,tdStr,jxStr,hbStr,shexStr,bhStr,nvStr];
        
        int i = 0;
        for (NSString *strName in arr) {
            
            NSString *lastStr = [NSString stringWithFormat:@"%@%@",strName,infoArr[i]];
            [self.totalinfos addObject:lastStr];
            i++;
        }
        
        
        
        for (int i = 1; i<8; i++) {
            FXBoard *board = [self createBoard:dict andIndex:i];
            [self.totalBoards addObject:board];
        }
        
        FXBoard *addBoard = [[FXBoard alloc]init];
        [self.totalBoards insertObject:addBoard atIndex:6];
        
        [self.BoardcollectionView reloadData];
        [self.infoCollectionView reloadData];
        
        
    } :^(NSError *error) {
        //
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.BoardcollectionView) {
        return 8;
    }
    return self.totalinfos.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.BoardcollectionView) {
        if (indexPath.item == 6) {
            RecordAddViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecordAddViewCellID forIndexPath:indexPath];
            return cell;
        }
        RecordOneViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecordOneViewCellID forIndexPath:indexPath];
        if (self.totalBoards.count) {
            cell.board = self.totalBoards[indexPath.item];
        }
        
        return cell;
    }
    
    SingleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SingleViewCellID forIndexPath:indexPath];
    cell.label.text = self.totalinfos[indexPath.row];
    return cell;
}


- (FXBoard *)createBoard:(NSDictionary *)dict andIndex:(int)index{
    
    FXBoard *board = [[FXBoard alloc]init];
    
    NSString *numStr = [NSString stringWithFormat:@"num%d",index];
    board.num = dict[numStr];
    
    NSString *colorStr = [numStr stringByAppendingString:@"bose"];
    board.color = dict[colorStr];
    
    NSString *shengxiaoStr = [numStr stringByAppendingString:@"shengxiao"];
    board.shengxiao = dict[shengxiaoStr];
    
    NSString *wuxingStr = [numStr stringByAppendingString:@"wuxing"];
    board.wuxing= dict[wuxingStr];
    
    return board;
}






//#pragma mark - 添加规格参数
//- (void)addParameter{
//        NALLabelsMatrix* matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(10, 114, 300, 100) andColumnsWidths:[[NSArray alloc] initWithObjects:@92,@208, nil]];
//    
//        [matrix addRecord:[[NSArray alloc] initWithObjects:@"商品介绍", @"124306833939243", nil]];
//        [matrix addRecord:[[NSArray alloc] initWithObjects:@"材料", @"青椒切丁、红椒切丁.青椒切丁、红椒切丁青椒切丁、红椒切丁青椒切丁、红椒切丁", nil]];
//        [matrix addRecord:[[NSArray alloc] initWithObjects:@"商品规格", @"500g/份", nil]];
//        [matrix addRecord:[[NSArray alloc] initWithObjects:@"库存", @"150份",nil]];
//        [self.view addSubview:matrix];
//}

@end
