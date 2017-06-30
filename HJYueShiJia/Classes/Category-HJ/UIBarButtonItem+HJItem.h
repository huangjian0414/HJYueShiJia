//
//  UIBarButtonItem+HJItem.h
//
//  Created by huangjian on 16/8/6.
//  Copyright (c) 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HJItem)
//设置UIBarButtonItem图片
+(UIBarButtonItem *)barBtnItemWithImg:(NSString *)image highImg:(NSString *)highimage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

//设置UIBarButtonItem文字
+(UIBarButtonItem *)barBtnItemWithText:(NSString *)text textColor:(UIColor *)color target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
