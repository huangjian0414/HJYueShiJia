//
//  HJTabBar.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJTabBar.h"

@implementation HJTabBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)click:(UIControl *)tabBarBtn
{
    for (UIView *imageView in tabBarBtn.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //[imageView.layer addAnimation:[self scaleAnim] forKey:nil];
            
            imageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
            [UIView animateWithDuration:0.6 animations:^{
                imageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }];
        }
    }
}
-(CAKeyframeAnimation *)scaleAnim
{
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.values=@[@1,@1.3,@0.9,@1.15,@0.95,@1.02,@1];
    anim.duration=1;
    anim.calculationMode=kCAAnimationCubic;
    
    return anim;
}


@end
