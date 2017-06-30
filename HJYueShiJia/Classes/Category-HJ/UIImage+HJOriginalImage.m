//
//  UIImage+HJOriginalImage.m
//
//  Created by huangjian on 16/8/2.
//  Copyright (c) 2016年 huangjian. All rights reserved.
//

#import "UIImage+HJOriginalImage.h"

@implementation UIImage (HJOriginalImage)

//图片渲染模式：始终绘制图片原始状态
+ (UIImage *)originalImageIgnoredRenderWithImageName:(NSString *)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:1];
}

//根据图片名返回自由拉伸的图片
+(UIImage *)stretchableImageWithName:(NSString *)imageName capWidth:(CGFloat)Wfloat capHeight:(CGFloat)Hfloat
{
    UIImage *image=[UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*Wfloat topCapHeight:image.size.height*Hfloat];
}

/*
 * 根据文字生成水印图片
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textRect:(CGRect)rect;

{
    UIImage *image = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //把图片画上去
    [image drawAtPoint:CGPointZero];
    
    //绘制文字到图片
    NSMutableDictionary *arrt = [NSMutableDictionary dictionary];
    arrt[NSFontAttributeName] = [UIFont systemFontOfSize:20.0];
    [str drawInRect:rect withAttributes:arrt];
    
    // 从上下文获取图片
    UIImage *imageWater = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return imageWater;
}
/*
 * 根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
//通过Rect剪裁图片
- (UIImage *)imageByCropToRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

// 生成一个圆形图片
+ (UIImage *)circleImageNamed:(NSString *)imgName
{
    UIImage *image=[UIImage imageNamed:imgName];
    UIGraphicsBeginImageContext(image.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片到圆上面
    [image drawInRect:rect];
    
    // 获得图片
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return image1;

}

/*
 * 图片裁剪，适用于圆形头像之类
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    // 图片的宽度和高度
    CGFloat imageWH = image.size.width;
    
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    
    // 圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2 * border;
    
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [color set];
    
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}

/*
 * 截屏或者截取部分视图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView
{
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控件上的图层渲染到上下文
    [captureView.layer renderInContext:ctx];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return screenImage;
    
}

@end
