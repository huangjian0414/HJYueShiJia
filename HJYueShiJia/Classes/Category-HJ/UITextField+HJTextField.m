//
//  UITextField+HJTextField.m
//
//  Created by huangjian on 16/4/21.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import "UITextField+HJTextField.h"

@implementation UITextField (HJTextField)
+ (UITextField *)initWithFrame:(CGRect)frame BackgroundImage:(UIImage *)backgroundImage SearchImage:(UIImage *)searchImage
{
    UITextField *hjTextField=[[UITextField alloc]initWithFrame:frame];
    hjTextField.font=[UIFont systemFontOfSize:13];
    hjTextField.background=backgroundImage;
    
    UIImageView *imageV=[[UIImageView alloc]initWithImage:searchImage];
    imageV.bounds=CGRectMake(0, 0, 30, 40);
    imageV.contentMode=UIViewContentModeCenter;
    
    hjTextField.leftView=imageV;
    hjTextField.leftViewMode=UITextFieldViewModeAlways;
    hjTextField.returnKeyType=UIReturnKeySearch;
    hjTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    hjTextField.enablesReturnKeyAutomatically=YES;
    return hjTextField;
}
/**
 *  设置占位文字颜色
 */
-(void)setHj_placeholderColor:(UIColor *)hj_placeholderColor
{
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    // 处理xmg_placeholderColor为nil的情况：如果是nil，恢复成默认的占位文字颜色
    if (hj_placeholderColor == nil) {
        hj_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:hj_placeholderColor forKeyPath:@"placeholderLabel.textColor"];
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)hj_placeholderColor
{
    return [self valueForKeyPath:@"placeholderLabel.textColor"];
}
@end
