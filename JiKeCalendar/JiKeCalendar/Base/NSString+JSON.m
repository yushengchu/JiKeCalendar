//
//  NSString+JSON.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/29.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

+(NSString*)stringWithJSONObject:(id)object{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return jsonString;
}

@end
