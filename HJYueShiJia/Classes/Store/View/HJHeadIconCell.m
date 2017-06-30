//
//  HJHeadIconCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/9.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJHeadIconCell.h"

@interface HJHeadIconCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation HJHeadIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setModel:(HJHeadIconModel *)model
{
    _model=model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.tag_img]];
    self.titleLabel.text=model.tag_name;
}
@end
