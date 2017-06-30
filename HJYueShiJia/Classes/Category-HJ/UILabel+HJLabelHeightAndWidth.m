//
//  UILabel+HJLabelHeightAndWidth.m
//
//  Created by huangjian on 16/8/25.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import "UILabel+HJLabelHeightAndWidth.h"

@implementation UILabel (HJLabelHeightAndWidth)
+ (CGFloat)hj_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)hj_getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
//中划线
+(NSAttributedString *)midLineWithString:(NSString *)text
{
    NSDictionary *attriDic=@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSStrikethroughColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:text attributes:attriDic];
    return attriStr;
}
//下划线
+(NSAttributedString *)underLineWithString:(NSString *)text
{
    NSDictionary *attriDic=@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSStrikethroughColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:text attributes:attriDic];
    return attriStr;
}
@end
