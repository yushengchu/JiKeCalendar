//
//  TodayViewController.h
//  calendar
//
//  Created by joker on 2019/1/15.
//  Copyright © 2019 sandsyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *isFridayLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UIView *isFridayView;
@property (weak, nonatomic) IBOutlet UIView *cardView;

@end
