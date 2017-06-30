//
//  HJXsyhView.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJXsyhView.h"

@interface HJXsyhView ()
@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *nowPriceLabel;

@property (nonatomic, weak) UILabel *oldPriceLabel;

@property (nonatomic, weak)  UILabel *descLabel;

@end
@implementation HJXsyhView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:imageView];
    self.imgView=imageView;
    
    UIImageView *backgroundView=[[UIImageView alloc]init];
    backgroundView.image=[UIImage imageNamed:@"InfoCelltitle"];
    [imageView addSubview:backgroundView];
    
    UILabel *title=[[UILabel alloc]init];
    title.font = [UIFont systemFontOfSize:17.0];
    title.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:title];
    self.titleLabel=title;
    
    UILabel *nowPriceLabel = [[UILabel alloc] init];
    nowPriceLabel.font = [UIFont systemFontOfSize:16.0];
    nowPriceLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:nowPriceLabel];
    self.nowPriceLabel = nowPriceLabel;
    
    UILabel *oldPriceLabel = [[UILabel alloc] init];
    [backgroundView addSubview:oldPriceLabel];
    oldPriceLabel.font = [UIFont systemFontOfSize:13.0];
    oldPriceLabel.textAlignment = NSTextAlignmentCenter;
    oldPriceLabel.textColor = [UIColor lightGrayColor];
    self.oldPriceLabel = oldPriceLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:11.0];
    descLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:descLabel];
    self.descLabel = descLabel;
    
    UIView *aLine = [[UIView alloc] init];
    aLine.backgroundColor = RGB(230, 198, 168, 1);
    [backgroundView addSubview:aLine];
    
    UIView *bLine = [[UIView alloc] init];
    bLine.backgroundColor = RGB(230, 198, 168, 1);
    [backgroundView addSubview:bLine];
    
    backgroundView.sd_layout.leftSpaceToView(imageView,50).topSpaceToView(imageView,20).rightSpaceToView(imageView,50).bottomSpaceToView(imageView,20);
    title.sd_layout.leftSpaceToView(backgroundView,20).topSpaceToView(backgroundView,28).rightSpaceToView(backgroundView,20).heightIs(25);
    aLine.sd_layout.topSpaceToView(title,8).leftSpaceToView(backgroundView,40).rightSpaceToView(backgroundView,40).heightIs(1);
    nowPriceLabel.sd_layout.leftEqualToView(aLine).topSpaceToView(aLine,5).heightIs(25).widthRatioToView(aLine,0.5);
    oldPriceLabel.sd_layout.topEqualToView(nowPriceLabel).rightEqualToView(aLine).heightRatioToView(nowPriceLabel,1).widthRatioToView(aLine,0.5);
    bLine.sd_layout.leftEqualToView(aLine).rightEqualToView(aLine).topSpaceToView(nowPriceLabel,5).heightRatioToView(aLine,1);
    descLabel.sd_layout.leftEqualToView(bLine).rightEqualToView(bLine).topSpaceToView(bLine,8).heightIs(21);
    
}
-(void)setChannelDict:(NSDictionary *)channelDict
{
    _channelDict=channelDict;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:channelDict[@"goods_img"]]];
    self.titleLabel.text=channelDict[@"title"];
    self.nowPriceLabel.text=[NSString stringWithFormat:@"￥%@",channelDict[@"zhekou"]];
    self.oldPriceLabel.attributedText=[UILabel midLineWithString:channelDict[@"goods_price"]];
    self.descLabel.text=channelDict[@"goods_name"];
    
}


@end
