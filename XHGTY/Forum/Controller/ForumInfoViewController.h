//
//  ForumInfoViewController.h
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXforum;

@interface ForumInfoViewController : UIViewController

@property (nonatomic,strong)FXforum *forum;
@property (nonatomic,assign)BOOL iscollection;
@end
