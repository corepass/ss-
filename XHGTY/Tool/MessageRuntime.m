//
//  MessageRuntime.m
//  YunGou
//
//  Created by bm on 16/12/29.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "MessageRuntime.h"
#import <objc/runtime.h>
@implementation MessageRuntime
-(void)receiveRemoteNotificationuserInfo:(NSDictionary *)userInfo needLoginView:(void (^)(BOOL needlogin , UIViewController * viewController))receive
{
    BOOL isNeed = NO;
//    NSArray * array = @[@"MyredpacketsViewController",@"IndianReecordPageView",@"WinningrecordViewController",@"RechargeViewController",@"ZeroSnatchDetailViewController"];
 
    
    NSDictionary * params = [NSDictionary dictionaryWithDictionary:userInfo];
    //类名
   
    NSString *class =  [params objectForKey:@"class"];
//    if ([array indexOfObject:class] != NSNotFound){
//        isNeed = YES;
//    }
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    //根据字符串返回一个类
    Class newClass = objc_getClass(className);
//    
//    if (!newClass) {
//
//        NSString *swiftclass = [NSString stringWithFormat:@"YunGou.%@",[params objectForKey:@"class"]];
//        const char *swiftclassName = [swiftclass cStringUsingEncoding:NSASCIIStringEncoding];
//        //根据字符串返回一个类
//         newClass = objc_getClass(swiftclassName);
//    }
    
    //创建对象
    id instance = [[newClass alloc]init ];
    
    
    //增加class 里面的属性
    NSDictionary *propertys = params[@"property"];
    
    [propertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //检测这个对象是否 存在这个属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            //利用KVC赋值
            if (![obj isKindOfClass:[NSNull class]] && obj!=nil) {  //赋值不能为空
                [instance setValue:obj forKey:key];
            }
            
            
        }
        
    }];
    
    
    

    receive(isNeed ,instance);

//    return  instance;

}
//检测对象是否有该属性
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    unsigned int outCount ,i;
    
    //获得对象里的属性列表
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount); //使用了objc_property_t 一定要释放
    
    for (i=0; i<outCount; i++) {
        objc_property_t propery = properties[i];
        //属性名转字符串
        NSString *properyName = [[NSString alloc]initWithCString:property_getName(propery) encoding:NSUTF8StringEncoding ];
        
        //判断该属性是否存在
        if ([properyName isEqualToString:verifyPropertyName]) {
            return YES;
        }
    }
    
    free(properties);
    
    return NO;
    
    
}


@end
