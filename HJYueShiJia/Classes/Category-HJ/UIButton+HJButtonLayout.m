//
//  UIButton+HJButtonLayout.m
//
//  Created by huangjian on 17/1/26.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIButton+HJButtonLayout.h"

@implementation UIButton (HJButtonLayout)
- (void)layoutButtonWithEdgeInsetsStyle:(HJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    
    switch (style) {
        case HJButtonEdgeInsetsStyleTop:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0, 0, -self.titleLabel.intrinsicContentSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(self.currentImage.size.height+space, -self.currentImage.size.width, 0, 0)];
            
        }
            break;
        case HJButtonEdgeInsetsStyleLeft:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, 0)];
        }
            break;
        case HJButtonEdgeInsetsStyleBottom:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(self.titleLabel.intrinsicContentSize.height, 0, 0, -self.titleLabel.intrinsicContentSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-self.currentImage.size.height-space, -self.currentImage.size.width, 0, 0)];
        }
            break;
        case HJButtonEdgeInsetsStyleRight:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,self.titleLabel.intrinsicContentSize.width , 0, -self.titleLabel.intrinsicContentSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.currentImage.size.width-space, 0, self.currentImage.size.width+space)];
        }
            break;
        default:
            break;
    }
 
}


@end
