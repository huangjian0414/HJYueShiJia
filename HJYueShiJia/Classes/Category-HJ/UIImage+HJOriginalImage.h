//
//  UIImage+HJOriginalImage.h
//
//  Created by huangjian on 16/8/2.
//  Copyright (c) 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJOriginalImage)
//图片渲染模式：始终绘制图片原始状态
+ (UIImage *)originalImageIgnoredRenderWithImageName:(NSString *)imageName;

//根据图片名返回拉伸倍数的图片
+(UIImage *)stretchableImageWithName:(NSString *)imageName capWidth:(CGFloat)Wfloat capHeight:(CGFloat)Hfloat;

/*
 * 根据文字生成水印图片
 * rect 是相对图片大小的位置
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textRect:(CGRect)rect;

// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//通过Rect剪裁图片
- (UIImage *) imageByCropToRect:(CGRect)rect;
// 生成一个圆形图片
+ (UIImage *)circleImageNamed:(NSString *)imgName;

/*
 * 图片裁剪，适用于圆形头像之类
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/*
 * 截屏或者截取部分视图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView;
@end
