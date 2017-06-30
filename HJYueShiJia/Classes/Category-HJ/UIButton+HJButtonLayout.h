//
//  UIButton+HJButtonLayout.h
//
//  Created by huangjian on 17/1/26.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HJButtonLayout)

typedef NS_ENUM(NSUInteger, HJButtonEdgeInsetsStyle) {
    HJButtonEdgeInsetsStyleTop, // image在上，label在下
    HJButtonEdgeInsetsStyleLeft, // image在左，label在右
    HJButtonEdgeInsetsStyleBottom, // image在下，label在上
    HJButtonEdgeInsetsStyleRight // image在右，label在左
};


- (void)layoutButtonWithEdgeInsetsStyle:(HJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


@end
