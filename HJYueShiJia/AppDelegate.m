//
//  AppDelegate.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "AppDelegate.h"
#import "HJTabbarVC.h"
#import "HJNewFeatureVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [self showReachabilityLabelWithStatus:status];
        [self performSelector:@selector(hiddenReachabilityLabel) withObject:nil afterDelay:2.0];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self chooseRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)showReachabilityLabelWithStatus:(AFNetworkReachabilityStatus)status
{
    UILabel *label=[[UIApplication sharedApplication].keyWindow viewWithTag:1314];
    if (!label) {
        label=[[UILabel alloc]init];
        label.tag=1314;
        label.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenReachabilityLabel)];
        [label addGestureRecognizer:tap];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:16];
        [[UIApplication sharedApplication].keyWindow addSubview:label];
        
    }
    label.backgroundColor=(status==AFNetworkReachabilityStatusReachableViaWiFi)?RGB(75, 135, 222, 1):RGB(253, 105, 105, 1);
    NSString *statusMessage;
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            statusMessage=@"当前网络状态未知";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            statusMessage=@"失去网络连接";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            statusMessage=@"正在使用蜂窝数据";
            break;
            
        default:
            statusMessage=@"正在使用WIFI网络";
            break;
    }
    label.text=statusMessage;
    [UIView animateWithDuration:0.5 animations:^{
        label.frame=CGRectMake(0, 0, Width, 69);
    }];
    
}
-(void)hiddenReachabilityLabel
{
    UILabel *label=[[UIApplication sharedApplication].keyWindow viewWithTag:1314];
    if (label) {
        [UIView animateWithDuration:0.5 animations:^{
            label.frame=CGRectMake(0, 0, Width, 0);
        } completion:^(BOOL finished) {
            if (finished) {
                [label removeFromSuperview];
            }
        }];
    }
}

-(void)chooseRootViewController
{
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleShortVersionString"];
    
    NSString *infoPath=[[NSBundle mainBundle]pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:infoPath];
    NSString *currentVersion=dict[@"CFBundleShortVersionString"];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        
        HJTabbarVC *tabbarVc=[[HJTabbarVC alloc]init];
        self.window.rootViewController=tabbarVc;
        
    }else
    {
        HJNewFeatureVC *vc=[[HJNewFeatureVC alloc]init];
        self.window.rootViewController=vc;
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"CFBundleShortVersionString"];
    }

}

@end
