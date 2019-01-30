//
//  JiKeURLSessionHelper.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/29.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "JiKeURLSessionHelper.h"
#import "NSString+JSON.h"

@implementation JiKeURLSessionHelper

+(JiKeURLSessionHelper*)shared{
    static JiKeURLSessionHelper *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[[self class] alloc] init];
    });
    return sharedMyManager;
}

-(JiKeURLSessionHelper*)init{
    if(self = [super init]){
        NSLog(@"MXURLSessionHelper init");
        _session = [NSURLSession sharedSession];
    }
    return self;
}

- (void)postJsonRequestWithUrl:(NSString *)url params:(id)params headers:(NSDictionary *)headers finish:(FinishBlock)finish {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:url]];
    request.timeoutInterval = 30;
    for(NSString *key in headers){
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    if(params != nil){
        NSString *bodyString = [NSString stringWithJSONObject:params];
        request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSLog(@"post request url:%@",url);
    NSLog(@"params:%@",params);
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (error)
            {
                NSLog(@"POST request error: \n%@",[error description]);
                finish(0,nil);
                return;
            }
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode <300) {
                NSError *theError;
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&theError];
                NSLog(@"POST request succ: \n%@",jsonData);
                //解析成功，为JSON格式
                if(theError == nil){
                    finish(1,jsonData);
                }else{
                    //解析失败
                    NSLog(@"JSONSerialization fail,theError:%@",theError);
                    finish(0,nil);
                }
            }else{
                if(!data){
                    finish(0,nil);
                    return;
                }
                NSLog(@"GET request fail:%ld,%@",(long)httpResponse.statusCode,[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                NSError *theError;
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&theError];
                //解析成功，为JSON格式
                if(theError == nil){
                    finish(0,jsonData);
                }else{
                    //解析失败
                    NSLog(@"JSONSerialization fail");
                    finish(0,nil);
                }
            }
        });
    }];
    [dataTask resume];
}


@end
