//
//  HttpTools.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/14.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "HttpTools.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkReachabilityManager.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
#import "AppModel.h"

@implementation HttpTools


+ (void)loadData:(void(^)(NSString *))finishedCallBack{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"已经发送了网络请求:%@",[NSThread currentThread]);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程:%@",[NSThread currentThread]);
            
            finishedCallBack(@"JSON数据");
            
        });
        
    });
}
+ (void)getCustonWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{


    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD show];
    NSURL * url = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray * array = [[HttpTools alloc] qudiaohtml: str];
           success(array);
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            failure(error);
        }
        
    }];
    [dataTask resume];
    
 

}
-(NSMutableArray *)qudiaohtml:(NSString *)content{
    NSScanner * scanner = [NSScanner scannerWithString:content];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        content = [content stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    content = [NSString stringWithFormat:@"[%@]",content];
    NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

         
    
    return  array;
    
    
}

+ (void)getWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    

    
    if ([path containsString:UPDATE_URL] || [path containsString:@"f.api"] || [path containsString:@"http://www.wns4688.com/"] || [path containsString:@"http://v.juhe.cn/toutiao"]) {
        
    }else{
         path = [NSString stringWithFormat:@"%@%@",kHostURL,path];
    }
    
    
    FxLog(@"path = %@ , parms = %@",path,parms);
    
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        
        if ([path containsString:@"f.api"] || [path containsString:UPDATE_URL] || [path containsString:@"http://www.wns4688.com/"] || [path containsString:@"http://v.juhe.cn/toutiao"]) {
            success(responseObject);
            return ;
        }
        
        if ([responseObject[@"status"]intValue]) {
            success(responseObject);
        }else{
            //[FXTools showErrorMsg:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        failure(error);
    }];
}

+ (void)postWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    path = [NSString stringWithFormat:@"%@%@",kHostURL,path];
   FxLog(@"path = %@ , parms = %@",path,parms);
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:path parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([responseObject[@"status"]intValue]) {
            [SVProgressHUD dismiss];
           success(responseObject);
        }else{
            //[FXTools showErrorMsg:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        failure(error);
    }];
   
}
+(void)getCustonCAIPIAOWithPath:(NSString *)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        if ([[responseObject allKeys] containsObject:@"data"]){
            success(responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        failure(error);
    }];
}
+ (void)GETWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD show];
    NSURL * url = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            success(str);
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            failure(error);
        }
        
    }];
    [dataTask resume];


}
+(void)POSTWithPath:(NSString *)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        failure(error);
    }];


}
+(void)postCustonCAIPIAOWithPath:(NSString *)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        if ([[responseObject allKeys] containsObject:@"data"]){
            success(responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        failure(error);
    }];
}

//+(void)getWithPathsuccess:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    static BOOL isSuccess;
//    NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [manager GET:[AppModel pinJieStr] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//                
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                isSuccess = YES;
//                [timer invalidate];
//                [time fire];
//                if (responseObject){
//                    if (![responseObject[@"url"] isEqualToString:@""]){
//                        static dispatch_once_t onceToken;
//                        dispatch_once(&onceToken, ^{
//                            success(responseObject[@"url"]);
//                        });
//                    }else{
//                    failure([[NSError alloc] init]);
//                    }
//                }else{
//                    failure([[NSError alloc] init]);
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                failure(error);
//            }];
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
// 
//}
+(void)getImaegWithPath:(NSString *)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure
{   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[AppModel pinJieStr] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject){
            if ([[responseObject allKeys] containsObject:@"data"]){
             success(responseObject);
            }
            }else{
            failure([[NSError alloc] init]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];


}
+ (void)downloadImageView:(UIImageView *)imageView withImageURL:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kPlaceImage options:SDWebImageDownloaderLowPriority | SDWebImageRetryFailed];
}


@end
