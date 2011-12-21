//
//  ClockAppDelegate.h
//  Clock
//
//  Created by 早河 優 on 11/11/15.
//  Copyright (c) 2011 東京. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClockViewController;

@interface ClockAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ClockViewController *viewController;

@end
