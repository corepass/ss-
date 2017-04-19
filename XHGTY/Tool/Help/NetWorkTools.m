//
//  NetWorkTools.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "NetWorkTools.h"
#import "SVProgressHUD.h"

@implementation NetWorkTools

single_implementation(NetWorkTools)


-(void)requestWithType:(RequesType)type urlString:(NSString *)urlStr parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure {
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html",@"text/plain", nil];
    
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    void(^sccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    };
    
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        [SVProgressHUD dismiss];
        NSLog(@"error = %@",[error localizedDescription]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
        
    };
    
    if (type == RequesTypeGET) {
        [self GET:urlStr parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }else {
        [self POST:urlStr parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }
}



- (void)getCustonWithPath:(NSString*)path parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL * url = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
           
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray * array = [self qudiaohtml: str];
            success(array);
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
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


@end
