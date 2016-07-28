//
//  UIViewController+MSForeNotification.m
//  iOS-Foreground-Push-Notification
//
//  Created by mr.scorpion on 16/7/21.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "UIViewController+MSForeNotification.h"
#import <objc/runtime.h>

@implementation UIViewController (MSForeNotification)

static BOOL _MSForegroundNotificationStatusBarHidden;

- (void)setMSForegroundNotificationStatusBarHidden:(BOOL)MSForegroundNotificationStatusBarHidden{
    NSNumber *t = @(MSForegroundNotificationStatusBarHidden);
    objc_setAssociatedObject(self, &_MSForegroundNotificationStatusBarHidden, t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)MSForegroundNotificationStatusBarHidden{
    NSNumber *t = objc_getAssociatedObject(self, &_MSForegroundNotificationStatusBarHidden);
    return [t boolValue];
}

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(BOOL)prefersStatusBarHidden{
    return self.MSForegroundNotificationStatusBarHidden;
}

@end
 
