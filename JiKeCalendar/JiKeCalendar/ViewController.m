//
//  ViewController.m
//  JiKeCalendar
//
//  Created by joker on 2019/1/15.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import "ViewController.h"
#import "JikeTools.h"
#import "JikeBaseConfig.h"
#import "UIView+Frame.h"
#import "JiKeAPIService.h"
#import "JiKeUserDefaults.h"

@interface ViewController ()
@property (nonatomic, copy) NSDictionary* data;
@property (nonatomic, strong) UILabel* hintLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderUI];
    [self getCalendarData];
}

- (void)renderUI {
    NSLog(@"scale ------%f",kScale(1));
    //设置背景颜色 周五为黄底白框 其他时间为白底黄框
    self.view.backgroundColor = [JikeTools isFriday] ? FridayBGColor : OtherDayBGColor;
    [self rendrContent];
}

- (void)rendrContent {
    
    UIScrollView* contentScro = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    UILabel* weekDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, MX_NAVIGATION_BAR_HEIGHT, kScreenWidth-15, 35)];
    weekDayLabel.text = [JikeTools getWeekWithString];
    weekDayLabel.font = [UIFont fontWithName:@"Hiragino Mincho ProN" size:kScale(25)];
    
    UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, MX_NAVIGATION_BAR_HEIGHT + kScale(30), kScreenWidth-15, 20)];
    dateLabel.text = [JikeTools getDateWithMonthAndDay];
    dateLabel.font = [UIFont fontWithName:@"Hiragino Mincho ProN" size:kScale(12)];
    
    [contentScro addSubview:weekDayLabel];
    [contentScro addSubview:dateLabel];
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, dateLabel.bottomY + kMarginScale(40), kScale(240), 50)];
    contentLabel.centerX = self.view.centerX;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.backgroundColor = [JikeTools isFriday] ? OtherDayBGColor : FridayBGColor;
    contentLabel.text = @"今天是不是『周五』？";
    contentLabel.layer.cornerRadius = 25;
    contentLabel.layer.masksToBounds = YES;
    contentLabel.font = [UIFont fontWithName:@"Hiragino Mincho ProN" size:kScale(18)];
    [contentScro addSubview:contentLabel];
    
    UIImageView* arrawImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, contentLabel.bottomY-8, 20, 20)];
    arrawImageView.image = [UIImage imageNamed:@"arraw_yellow"];
    arrawImageView.centerX = self.view.centerX;
    [contentScro addSubview:arrawImageView];
    
    UILabel* isFriday = [[UILabel alloc] initWithFrame:CGRectMake(0, contentLabel.bottomY + kMarginScale(70), kScreenWidth, 80)];
    isFriday.text = [JikeTools isFriday] ? @"是" : @"不是";
    isFriday.textAlignment = NSTextAlignmentCenter;
    isFriday.font = [UIFont systemFontOfSize:kScale(115) weight:UIFontWeightBold];
    [contentScro addSubview:isFriday];
    
    
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, isFriday.bottomY + kMarginScale(60), kScreenWidth-80, 130)];
    _hintLabel.textAlignment = NSTextAlignmentCenter;
    _hintLabel.text = @"";
    _hintLabel.font = [UIFont systemFontOfSize:14];
    _hintLabel.numberOfLines = 0;
    [contentScro addSubview:_hintLabel];
    
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _hintLabel.bottomY + 10, kScreenWidth-40, 20)];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.text = @"";
    [contentScro addSubview:_authorLabel];
    
    contentScro.contentSize = CGSizeMake(kScreenWidth, _authorLabel.bottomY);
    contentScro.scrollEnabled = YES;
    [self.view addSubview:contentScro];
    
}

- (void)getCalendarData {
    
    NSString* date = [JikeTools getDateWithMonthAndDay];
    if ([JiKeUserDefaults getCalendarData:date]) {
        self.data = [JiKeUserDefaults getCalendarData:date];
        [self reloadData];
        return;
    }
    
    NSString* userid = [JikeTools getUserId];
    NSDictionary* params = @{
                             @"topicId": userid,
                             @"limit": @"20"
                             };
    [JiKeAPIService requestForCalendarData:params finish:^(NSInteger status, id data) {
        NSLog(@"data ----->%@",data);
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
    _hintLabel.text = self.data[@"content"];
    _authorLabel.text = [NSString stringWithFormat:@"—— %@",self.data[@"topic"][@"content"]];
}
@end
