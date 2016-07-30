//
//  DownLoad.m
//  iOS_PianKe
//
//  Created by zhiling on 16/7/21.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DownLoad.h"

@implementation DownLoad


+ (void)dowmLoadWithUrl:(NSString *)urls postBody:(NSString *)postBody resultBlock:(Block)resultBlock {
    
    if (postBody) {
        
        //1 创建网络URL
        
        NSURL *url = [NSURL URLWithString:urls];
        
        //2 创建网络请求
        //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        
        //设置请求方式
        request.HTTPMethod = @"POST";
 
        NSData *dataStr = [postBody dataUsingEncoding:NSUTF8StringEncoding];
        
        
        //参数
        request.HTTPBody = dataStr;
        //3 创建会话 -- 默认会话（单例）
        NSURLSession *session = [NSURLSession sharedSession];
        
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
//            NSLog(@"%@", data);
            
            resultBlock(data);
            
                  }];
        
            [task resume];
        
    }else {
        
        
        NSURL *url = [NSURL URLWithString:urls];
        
        //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //通过block将请求到得数据传到外面
            resultBlock(data);
            
        }];
        [task resume];
        
        
    }

}

@end
