//
//  JiKeUserDefaults.h
//  JiKeCalendar
//
//  Created by joker on 2019/1/30.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiKeUserDefaults : NSObject
+ (void)saveCalendarData:(NSDictionary*)data date:(NSString*)date;
+ (NSDictionary*)getCalendarData:(NSString*)date;

@end

