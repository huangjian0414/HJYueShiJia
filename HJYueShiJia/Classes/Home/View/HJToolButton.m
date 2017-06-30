//
//  HJToolButton.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJToolButton.h"

@implementation HJToolButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        self.imageView.contentMode=UIViewContentModeCenter;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageX=0;
    CGFloat imageY=0;
    CGFloat imageW=self.bounds.size.width;
    CGFloat imageH=self.bounds.size.height*0.7;
    self.imageView.frame=CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleX=0;
    CGFloat titleY=CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW=self.bounds.size.width;
    CGFloat titleH=self.bounds.size.height-titleY;
    self.titleLabel.frame=CGRectMake(titleX, titleY, titleW, titleH);
    
}
@end
