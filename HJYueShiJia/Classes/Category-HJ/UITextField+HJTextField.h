//
//  UITextField+HJTextField.h
//
//  Created by huangjian on 16/4/21.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (HJTextField)
+ (UITextField *)initWithFrame:(CGRect)frame BackgroundImage:(UIImage *)backgroundImage SearchImage:(UIImage *)searchImage;

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *hj_placeholderColor;
@end
