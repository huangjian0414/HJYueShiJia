//
//  HJNaviVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJNaviVC.h"

@interface HJNaviVC ()

@end

@implementation HJNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        [viewController setHidesBottomBarWhenPushed:YES];
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithImg:@"nav_return_normal" highImg:@"nav_return_normal" target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

@end
