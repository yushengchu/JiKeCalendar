//
//  JikeTools.h
//  JiKeCalendar
//
//  Created by joker on 2019/1/23.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JikeTools : NSObject

+ (NSString*)getWeekWithString;
+ (BOOL)isFriday;
+ (NSString*)getUserId;
+ (NSString*)getDateWithMonthAndDay;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSInteger)getFontSizeWithWeekDay;

@end
