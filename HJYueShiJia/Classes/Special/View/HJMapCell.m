//
//  HJMapCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJMapCell.h"

@interface HJMapCell ()
@property (weak, nonatomic) IBOutlet UILabel *localLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end
@implementation HJMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width=Width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HJMapModel *)model
{
    _model=model;
    self.localLabel.text=model.article_title;
    self.titleLabel.text=model.article_abstract;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.imgView.frame)+ 25;
}
@end
