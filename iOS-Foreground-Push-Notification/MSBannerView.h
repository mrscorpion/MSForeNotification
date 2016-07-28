//
//  MSBannerView.h
//  iOS-Foreground-Push-Notification
//
//  Created by mr.scorpion on 16/7/21.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BannerStayTime 4.7
#define BannerAnimationTime 0.3

@interface MSBannerView : UIView
@property (nonatomic, retain)NSDictionary *userInfo;
-(void)removeWithAnimation;
@end

static MSBannerView *SharedBannerView;
