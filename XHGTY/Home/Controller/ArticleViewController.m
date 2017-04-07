//
//  ArticleViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "ArticleViewController.h"
#import "LHArticle.h"
#import "HttpTools.h"
#import "AppDefine.h"
#import "AppURLdefine.h"

@interface ArticleViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UIButton *upTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextTextBtn;
@property (nonatomic,strong)LHArticle *currentArticle;
@property (nonatomic,assign)NSInteger currentIndex;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.targetArticle.post_title;
    
    self.currentArticle = self.targetArticle;
    
    self.currentIndex = [self.totalArticles indexOfObject:self.currentArticle];
    
    [self loadNewItems:self.targetArticle.ID];    
}

-(void)judgeBottomBtnHidden{
    self.upTextBtn.hidden = [self isFirstArticle];
    self.nextTextBtn.hidden = [self isLastArticle];
}

-(BOOL)isFirstArticle{
    return [self.currentArticle.ID isEqualToString:self.totalArticles.firstObject.ID];
}

-(BOOL)isLastArticle{
    return [self.currentArticle.ID isEqualToString:self.totalArticles.lastObject.ID];
}


- (void)loadNewItems:(NSString *)articleID{
    
    [HttpTools getWithPath:kLHDQArticle parms:@{@"article_id":articleID} success:^(id JSON) {
        
        FxLog(@"JSOn = %@",JSON);
        
        NSString *htmlData = JSON[@"data"][@"post_content"];
        
        [self.webView loadHTMLString:htmlData baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        [self judgeBottomBtnHidden];
    } :^(NSError *error) {
        //
    }];
}
- (IBAction)upAction:(UIButton *)sender {
    self.currentIndex -- ;
    if (self.currentIndex <0) {
        return;
    }
    self.currentArticle = self.totalArticles[self.currentIndex];
    self.title = self.currentArticle.post_title;
    [self loadNewItems:self.currentArticle.ID];
}
- (IBAction)nextAction:(UIButton *)sender {
    self.currentIndex ++ ;
    if (self.currentIndex == self.totalArticles.count) {
        return;
    }
    self.currentArticle = self.totalArticles[self.currentIndex];
    self.title = self.currentArticle.post_title;
    
    [self loadNewItems:self.currentArticle.ID];
}

@end
