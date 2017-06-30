//
//  UIColor+HJColor.h
//
//  Created by huangjian on 16/4/21.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface UIColor (HJColor)
+ (UIColor *)colorFromHexRGB:(NSString *)colorString;
@end
