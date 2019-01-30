//
//  JikeTools.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/23.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "JikeTools.h"

@implementation JikeTools

+ (NSString*)getWeekWithString {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    NSString *weekStr;
    if (weekday == 1) {
        weekStr = @"Sunday";
    }else if (weekday == 2){
        weekStr = @"Monday";
    }else if (weekday == 3){
        weekStr = @"Tuesday";
    }else if (weekday == 4){
        weekStr = @"Wednesday";
    }else if (weekday == 5){
        weekStr = @"Thursday";
    }else if (weekday == 6){
        weekStr = @"Friday";
    }else if (weekday == 7){
        weekStr = @"Saturday";
    }
    return weekStr;
}

+ (NSString*)getDateWithMonthAndDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

+ (BOOL)isFriday {
    NSString* weekDay = [JikeTools getWeekWithString];
    if ([weekDay isEqualToString:@"Friday"]) {
        return YES;
    }
    return NO;
}

+ (NSString*)getUserId {
    NSArray* userids = @[
                         @"5618c159add4471100150637", // 浴室沉思
                         @"557ed045e4b0a573eb66b751", // 无用但有趣的冷知识
                         @"5a82a88df0eddb00179c1df7", // 今日烂梗
                         @"572c4e31d9595811007a0b6b", // 弱智金句病友会
                         @"56d177a27cb3331100465f72", // 今日金句
                         @"5aa21c7ae54af10017dc93f8" // 一个想法不一定对
                         ];
    int r = arc4random() % [userids count];
    return userids[r];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSInteger)getFontSizeWithWeekDay{
    NSString *weekStr = [JikeTools getWeekWithString];
    if ([weekStr isEqualToString:@"Sunday"] || [weekStr isEqualToString:@"Monday"] || [weekStr isEqualToString:@"Tuesday"] || [weekStr isEqualToString:@"Friday"]) {
        return 21;
    }else if ([weekStr isEqualToString:@"Thursday"] || [weekStr isEqualToString:@"Saturday"]){
        return 20;
    }else{
        return 16;
    }
}

@end
