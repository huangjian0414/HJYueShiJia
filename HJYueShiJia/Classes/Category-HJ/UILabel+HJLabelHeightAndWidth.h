//
//  UILabel+HJLabelHeightAndWidth.h
//
//  Created by huangjian on 16/8/25.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HJLabelHeightAndWidth)
+ (CGFloat)hj_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)hj_getWidthWithTitle:(NSString *)title font:(UIFont *)font;

//中划线
+(NSAttributedString *)midLineWithString:(NSString *)text;
//下划线
+(NSAttributedString *)underLineWithString:(NSString *)text;
@end
