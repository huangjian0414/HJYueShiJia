//
//  UIBarButtonItem+HJItem.m
//
//  Created by huangjian on 16/8/6.
//  Copyright (c) 2016年 huangjian. All rights reserved.
//

#import "UIBarButtonItem+HJItem.h"

@implementation UIBarButtonItem (HJItem)
//设置UIBarButtonItem图片
+(UIBarButtonItem *)barBtnItemWithImg:(NSString *)image highImg:(NSString *)highimage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
//设置UIBarButtonItem文字
+(UIBarButtonItem *)barBtnItemWithText:(NSString *)text textColor:(UIColor *)color target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0] ];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
