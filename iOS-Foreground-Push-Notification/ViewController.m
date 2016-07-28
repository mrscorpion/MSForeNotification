//
//  ViewController.m
//  iOS-Foreground-Push-Notification
//
//  Created by mr.scorpion on 16/7/21.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSForeNotification.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hi) userInfo:nil repeats:NO];
}

-(void)hi{
    [MSForeNotification handleRemoteNotification:@{@"aps":@{@"alert":@"你好吗？我很好！"}} soundID:1312];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
