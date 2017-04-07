//
//  VideoDrawViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/6.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "VideoDrawViewController.h"
#import "RecordAddViewCell.h"
#import "RecordOneViewCell.h"
#import "FXBoard.h"
#import "WebViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HttpTools.h"
#import "AppDefine.h"
#import "AppURLdefine.h"

@interface VideoDrawViewController ()<UICollectionViewDataSource,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *totalBoards;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,assign)CGPoint offset;
@property (nonatomic,strong)NSMutableArray *postContents;
@end

@implementation VideoDrawViewController


static NSString *const RecordOneViewCellID = @"RecordOneViewCell";
static NSString *const RecordAddViewCellID = @"RecordAddViewCell";


- (NSMutableArray *)totalBoards{
    if (_totalBoards == nil) {
        _totalBoards = [NSMutableArray array];
    }
    return _totalBoards;
}

- (NSMutableArray *)postContents{
    if (_postContents == nil) {
        _postContents = [NSMutableArray array];
    }
    return _postContents;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"视频开奖";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordOneViewCell" bundle:nil] forCellWithReuseIdentifier:RecordOneViewCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake((kScreenW)/8, 70);
    
    
    self.webView.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems:)];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordAddViewCell" bundle:nil] forCellWithReuseIdentifier:RecordAddViewCellID];
    
    [self loadNewItems];
}


- (void)loadNewItems{
    
    [HttpTools getWithPath:kLHDQVideo parms:nil success:^(id JSON) {
        //
        
        NSDictionary *dict = JSON[@"contentinfo"];
        self.titleLabel.text = [NSString stringWithFormat:@"%@期开奖结果",dict[@"shortperiod"]];
        
        NSDictionary *infoDict = JSON[@"content"];
       
       [self.postContents addObject:infoDict[@"post_content"]];
        
        
        [self.webView loadHTMLString:self.postContents.firstObject baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        
        for (int i = 1; i<8; i++) {
            FXBoard *board = [self createBoard:dict andIndex:i];
            [self.totalBoards addObject:board];
        }
        
        FXBoard *addBoard = [[FXBoard alloc]init];
        [self.totalBoards insertObject:addBoard atIndex:6];
        
        [self.collectionView reloadData];
        
    } :^(NSError *error) {
        //
    }];
}


int pageNum = 1;
- (void)loadMoreItems:(NSString *)page{
    pageNum ++ ;
    [HttpTools getWithPath:kLHDQVideo parms:@{@"p":[NSString stringWithFormat:@"%d",pageNum]} success:^(id JSON) {
        //
  
        
        self.offset =  self.webView.scrollView.contentOffset;
        
       
         NSDictionary *infoDict = JSON[@"content"];
        [self.webView.scrollView.mj_footer endRefreshing];
        if ([infoDict isKindOfClass:[NSString class]]) {//没有数据
            self.webView.scrollView.mj_footer.hidden = YES;
            return ;
        }
        if (infoDict.allValues.count) {
            
            [self.postContents addObject:infoDict[@"post_content"]];
            NSMutableString *lastStr = [NSMutableString string];
            for (NSString *htmlStr in self.postContents) {
                [lastStr appendString:htmlStr];
            }
            
            [self.webView loadHTMLString:lastStr baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
            
            
        }else{
            self.webView.scrollView.mj_footer.hidden = YES;
        }
     
        
    } :^(NSError *error) {
        //
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView.scrollView setContentOffset:self.offset animated:NO];
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


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
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



@end
