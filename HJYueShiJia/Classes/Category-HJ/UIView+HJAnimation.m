//
//  UIView+HJAnimation.m
//
//  Created by huangjian on 17/1/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIView+HJAnimation.h"

@implementation UIView (HJAnimation)
//整体缩放动画
-(void)extendAnimation
{
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
//上下缩放动画
-(void)shutterAnimation
{
    self.layer.transform = CATransform3DMakeScale(1, 0.1, 0.1);
    [UIView animateWithDuration:0.35 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
//透明度缩放动画
-(void)graduatedAnimation
{
    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0;
    }];
}
//左右摇摆
- (void) shakeAnimation{
    CAKeyframeAnimation *keyAnim=[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat angel=(M_PI_4/3);
    keyAnim.values=@[@(angel),@(-angel),@(angel)];
//    keyAnim.removedOnCompletion = NO;
//    keyAnim.fillMode = kCAFillModeForwards;
    keyAnim.duration = 0.2;
    keyAnim.repeatCount = 2;
    [self.layer addAnimation:keyAnim forKey:nil];

}
//沿x|y|z轴旋转
-(void)rotationAnim:(NSString *)xyzString;
{
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"transform.rotation.%@",xyzString]];
    anim.toValue=@(2*M_PI);
    anim.repeatCount=2;
    anim.duration=1.0f;
    [self.layer addAnimation:anim forKey:nil];
    anim.removedOnCompletion=NO;
    anim.fillMode=kCAFillModeForwards;
}
//照相机动画
- (void)cameraAnim
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.33f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = @"cameraIrisHollowClose";
    animation.subtype = kCATransitionFromRight;
    
    [self.layer addAnimation:animation forKey:@"animation"];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.33f];
//    [UIView commitAnimations];
}
-(void)querCardAnim:(CGPoint)controlPoint EndPoint:(CGPoint)endPoint
{
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.repeatCount=1;
    anim.duration=1.0f;
    anim.fillMode=kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.calculationMode=kCAAnimationPaced;
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.center.x, self.center.y);
    CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
    anim.path=path;
    CGPathRelease(path);
    [self.layer addAnimation:anim forKey:nil];
}

@end
