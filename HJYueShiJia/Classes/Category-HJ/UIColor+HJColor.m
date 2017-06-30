//
//  UIColor+HJColor.m
//
//  Created by huangjian on 16/4/21.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import "UIColor+HJColor.h"

@implementation UIColor (HJColor)
+ (UIColor *)colorFromHexRGB:(NSString *)colorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != colorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:colorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end
