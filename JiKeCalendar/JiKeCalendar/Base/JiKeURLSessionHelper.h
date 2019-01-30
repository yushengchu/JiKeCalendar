//
//  JiKeURLSessionHelper.h
//  JiKeCalendar
//
//  Created by joker on 2019/1/29.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock) (NSInteger status,id data);

@interface JiKeURLSessionHelper : NSObject
@property (nonatomic,strong) NSURLSession *session;
+(JiKeURLSessionHelper*)shared;
- (void)postJsonRequestWithUrl:(NSString *)url params:(id)params headers:(NSDictionary *)headers finish:(FinishBlock)finish;
@end

