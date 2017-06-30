//
//  HJTabbarVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJTabbarVC.h"
#import "HJMeVC.h"
#import "HJStoreVC.h"
#import "HJSpecialVC.h"
#import "HJNaviVC.h"
#import "HJHomeVC.h"
#import "HJBasketVC.h"
#import "HJTabBar.h"
@interface HJTabbarVC ()

@end

@implementation HJTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildVC];
}
-(void)setChildVC
{
    HJHomeVC *home=[[HJHomeVC alloc]init];
    [self setOneChildController:home title:@"首页" nomarlImage:@"YS_index_nor" selectedImage:@"YS_index_sel"];
    HJSpecialVC *special=[[HJSpecialVC alloc]init];
    [self setOneChildController:special title:@"专题" nomarlImage:@"YS_pro_nor" selectedImage:@"YS_pro_sel"];
    HJStoreVC *store=[[HJStoreVC alloc]init];
    [self setOneChildController:store title:@"店铺" nomarlImage:@"YS_shop_nor" selectedImage:@"YS_shop_sel"];
    HJBasketVC *basket=[[HJBasketVC alloc]init];
    [self setOneChildController:basket title:@"购物篮" nomarlImage:@"YS_car_nor" selectedImage:@"YS_car_sel"];
    HJMeVC *me=[[HJMeVC alloc]init];
    [self setOneChildController:me title:@"我" nomarlImage:@"YS_mine_nor" selectedImage:@"YS_mine_sel"];
    
    HJTabBar *tabbar=[[HJTabBar alloc]init];
    [self setValue:tabbar forKey:@"tabBar"];
}
- (void)setOneChildController:(UIViewController *)vc title:(NSString *)title nomarlImage:(NSString *)nomarlImage selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:nomarlImage];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:168/255.0f green:168/255.0f blue:168/255.0f alpha:1]} forState:UIControlStateNormal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:211/255.0f green:192/255.0f blue:162/255.0f alpha:1]} forState:UIControlStateSelected];
    
    HJNaviVC *navi=[[HJNaviVC alloc]initWithRootViewController:vc];
    [self addChildViewController:navi];
}
-(BOOL)shouldAutorotate{
    HJNaviVC *nav = (HJNaviVC *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"HJVideoVC") class]]) {
        return YES;
    }
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    HJNaviVC *nav = (HJNaviVC *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"HJVideoVC") class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    HJNaviVC *nav = (HJNaviVC *)self.selectedViewController;
    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"HJVideoVC") class]]) {
        return UIInterfaceOrientationPortrait|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
    }
    return UIInterfaceOrientationPortrait;
    
}
@end
