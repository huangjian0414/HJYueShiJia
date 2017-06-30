//
//  UIView+HJAnimation.h
//
//  Created by huangjian on 17/1/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HJAnimation)
//整体缩放动画
- (void) extendAnimation;
//上下缩放动画
- (void) shutterAnimation;
//透明度缩放动画
- (void) graduatedAnimation;


//左右摇摆
- (void) shakeAnimation;

//沿x|y|z轴旋转
-(void)rotationAnim:(NSString *)xyzString;
//照相机动画
- (void)cameraAnim;

-(void)querCardAnim:(CGPoint)controlPoint EndPoint:(CGPoint)endPoint;
@end
