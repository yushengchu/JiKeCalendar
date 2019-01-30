//
//  JiKeAPIService.h
//  JiKeCalendar
//
//  Created by joker on 2019/1/29.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock) (NSInteger status,id data);

@interface JiKeAPIService : NSObject

+ (void)requestForCalendarData:(NSDictionary*)params finish:(FinishBlock)finis;

@end

