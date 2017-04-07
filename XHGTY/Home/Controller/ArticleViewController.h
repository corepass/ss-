//
//  ArticleViewController.h
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "BaseViewController.h"
@class LHArticle;

@interface ArticleViewController : BaseViewController
@property (nonatomic,copy)NSString *articleID;
@property (nonatomic,strong)NSArray <LHArticle*>*totalArticles;
@property (nonatomic,strong)LHArticle *targetArticle;
@end
