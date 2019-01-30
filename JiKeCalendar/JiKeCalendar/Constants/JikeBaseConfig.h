//
//  JikeBaseConfig.h
//
//  Created by joker on 2018/9/12.
//  Copyright © 2018年 sands. All rights reserved.
//

#ifndef JikeBaseConfig_h
#define JikeBaseConfig_h

/**
 *  设备信息
 */
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width  //设备的宽度
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height //设备的高度

//导航栏高度
#define getRectNavAndStatusHight  (self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)

#define mxTimeStamp [[NSDate date] timeIntervalSince1970] * 1000

// 状态栏高度
#define MX_STATUS_BAR_HEIGHT (isFullScreen ? 44.f : 20.f)
// 导航栏高度
#define MX_NAVIGATION_BAR_HEIGHT (isFullScreen ? 88.f : 64.f)
// tabBar高度
#define MX_TAB_BAR_HEIGHT (isFullScreen ? (49.f+34.f) : 49.f)
// home indicator高度
#define MX_HOME_INDICATOR_HEIGHT (isFullScreen ? 34.f : 0.f)

//不同分辨率的屏幕比例
#define kScale(a) ([UIScreen mainScreen].bounds.size.width)/320*(a)
#define kMarginScale(a) ([UIScreen mainScreen].bounds.size.width)/300*(a)


//颜色
#define UIColor3b(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColor4b(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//RGB颜色转换（16进制->10进制）
#define UIHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// iPhone X
#define MXiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// iPhoneXR
#define MXIPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)
// iPhoneXs Max
#define MXIPHONE_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
// 异性全面屏
#define   isFullScreen    (MXIPHONE_XR || MXIPHONE_XS_MAX || MXiPhoneX)


//颜色
#define FridayBGColor [UIColor colorWithRed:255.0/255.0 green:228.0/255.0 blue:17.0/255.0 alpha:0.8]
#define OtherDayBGColor [UIColor whiteColor]

#endif /* MXAIBaseConfig_h */
