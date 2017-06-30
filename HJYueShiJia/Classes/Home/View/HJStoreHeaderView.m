//
//  HJStoreHeaderView.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJStoreHeaderView.h"

@interface HJStoreHeaderView ()
@property (nonatomic,strong)UIImageView *imgView;
@end
@implementation HJStoreHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
    self.imgView=picImageView;
    [self addSubview:picImageView];
}
-(void)setImgURL:(NSString *)imgURL
{
    _imgURL=imgURL;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
}
@end
