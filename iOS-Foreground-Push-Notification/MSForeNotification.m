//
//  MSForeNotification.m
//  iOS-Foreground-Push-Notification
//
//  Created by mr.scorpion on 16/7/21.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSForeNotification.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "MSBannerView.h"
#import "UIViewController+MSForeNotification.h"

NSString *const MSBannerViewDidClick = @"MSBannerViewDidClick";

@implementation MSForeNotification

#pragma mark - public

+(void)handleRemoteNotification:(NSDictionary*)userInfo soundID:(int)soundID{
    if (userInfo) {
        [MSBannerView class];
        id aps = [userInfo valueForKey:@"aps"];
        if (aps && [aps isKindOfClass:[NSDictionary class]] && [aps valueForKey:@"alert"] && ![[aps valueForKey:@"alert"] isEqual: @""]) {
            [MSForeNotification showBannerWithUserInfo:userInfo soundID:soundID];
        }
    }
}

+(void)handleRemoteNotification:(NSDictionary*)userInfo customSound:(NSString*)soundName{
    if (soundName) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        SystemSoundID soundID = 0;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        [MSForeNotification handleRemoteNotification:userInfo soundID:soundID];
    }
}

#pragma mark - private

+(void)showBannerWithUserInfo:(NSDictionary*)userInfo soundID:(int)soundID{
    if (soundID) {
        AudioServicesPlaySystemSound(soundID);
    }
    if (SharedBannerView) {
        SharedBannerView = nil;
    }
    SharedBannerView = [[NSBundle mainBundle] loadNibNamed:@"MSBannerView" owner:nil options:nil].lastObject;
    UIViewController *controller = [MSForeNotification appRootViewController];
    SharedBannerView.userInfo = userInfo;
    [controller.view addSubview:SharedBannerView];
    [NSTimer scheduledTimerWithTimeInterval:BannerStayTime target:self selector:@selector(deletMSanner) userInfo:nil repeats:NO];
}

+(UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+(void)deletMSanner{
    if (SharedBannerView) {
        [SharedBannerView removeWithAnimation];
    }
}

@end
