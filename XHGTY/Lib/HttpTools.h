//
//  HttpTools.h
//  NewPuJing
//
//  Created by 杨健 on 2016/11/14.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NSError *error);

@interface HttpTools : NSObject
+ (void)loadData:(void(^)(NSString *))finishedCallBack;
+ (void)POSTWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)GETWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)getWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)getCustonWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)getCustonCAIPIAOWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)postWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+(void)postCustonCAIPIAOWithPath:(NSString *)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;

+ (void)getImaegWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
+ (void)downloadImageView:(UIImageView *)imageView withImageURL:(NSString *)url;
+(void)getWithPathsuccess:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
-(NSMutableArray *)qudiaohtml:(NSString *)content;
@end
