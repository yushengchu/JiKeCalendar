//
//  JiKeUserDefaults.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/30.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "JiKeUserDefaults.h"
#import "JiKeTools.h"
@implementation JiKeUserDefaults

+ (void)saveCalendarData:(NSDictionary*)data date:(NSString*)date {
    NSLog(@"save --- date:%@",date);
    NSString* jsonStr = [JikeTools dictionaryToJson:data];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.moxie.TFAuth"];
    [userDefaults setObject:jsonStr forKey:date];
    [userDefaults synchronize];
}

+ (NSDictionary*)getCalendarData:(NSString*)date {
    NSLog(@"get --- date:%@",date);
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.moxie.TFAuth"];
    NSString* strData = [userDefaults objectForKey:date];
    NSDictionary* data = [JikeTools dictionaryWithJsonString:strData];
    return data;
}


@end
