//
//  JiKeAPIService.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/29.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "JiKeAPIService.h"
#import "JiKeURLSessionHelper.h"
#import "JiKeAPIList.h"

@implementation JiKeAPIService

+ (void)requestForCalendarData:(NSDictionary*)params finish:(FinishBlock)finish {
    [[JiKeURLSessionHelper shared] postJsonRequestWithUrl:JiKeCalendarDataUrl params:params headers:@{} finish:^(NSInteger status, id data) {
        finish(status, data);
    }];
}

@end
