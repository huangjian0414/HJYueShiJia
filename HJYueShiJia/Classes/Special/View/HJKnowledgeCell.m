//
//  HJKnowledgeCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJKnowledgeCell.h"

@interface HJKnowledgeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end
@implementation HJKnowledgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width=Width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HJKnowledgeModel *)model
{
    _model=model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    self.titleLabel.text=model.article_title;
    self.descLabel.text=model.article_abstract;
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.descLabel.frame)+ 25;
}
@end
