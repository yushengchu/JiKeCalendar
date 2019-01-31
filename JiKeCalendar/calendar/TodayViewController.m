//
//  TodayViewController.m
//  calendar
//
//  Created by joker on 2019/1/15.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "JiKeUserDefaults.h"
#import "JikeTools.h"
#import "JiKeAPIService.h"
#import "JikeBaseConfig.h"
#import "UIView+Frame.h"

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, copy) NSDictionary* data;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        // 设置展开的新高度
        self.preferredContentSize = CGSizeMake(0, self.authorLabel.bottomY+10);
    }else{
        self.preferredContentSize = maxSize;
    }
}

- (void)configData {
    
    self.weekDayLabel.text = [JikeTools getWeekWithString];
    self.weekDayLabel.font = [UIFont fontWithName:@"Hiragino Mincho ProN" size:[JikeTools getFontSizeWithWeekDay]];
    
    self.monthLabel.text = [JikeTools getDateWithMonthAndDay];
    self.isFridayLabel.text = [JikeTools isFriday] ? @"是" : @"不是";
    self.isFridayView.backgroundColor = [JikeTools isFriday] ? FridayBGColor : OtherDayBGColor;
    self.cardView.backgroundColor = [JikeTools isFriday] ? OtherDayBGColor : FridayBGColor;
    
    
    NSString* date = [JikeTools getDateWithMonthAndDay];
    NSDictionary* data = [JiKeUserDefaults getCalendarData:date];
    if (data) {
        self.data = data;
        [self reloadData];
    }else {
        [self requestCalendarData];
    }
    
}

- (void)requestCalendarData {
    NSString* date = [JikeTools getDateWithMonthAndDay];
    NSString* userid = [JikeTools getUserId];
    NSDictionary* params = @{
                             @"topicId": userid,
                             @"limit": @"20"
                             };
    [JiKeAPIService requestForCalendarData:params finish:^(NSInteger status, id data) {
        if (status && data) {
            NSArray* list = data[@"data"];
            if (list && list.count >0 ) {
                int r = arc4random() % [list count];
                self.data = list[r];
                [JiKeUserDefaults saveCalendarData:list[r] date:date];
            }
        }
        [self reloadData];
    }];
}


- (void)reloadData {
    self.contentLabel.text = self.data[@"content"];
    self.authorLabel.text = [NSString stringWithFormat:@"—— %@",self.data[@"topic"][@"content"]];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

@end
