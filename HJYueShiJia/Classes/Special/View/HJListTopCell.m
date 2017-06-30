//
//  HJListTopCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/7.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJListTopCell.h"

@interface HJListTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UILabel *abstructLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *formLabel;

@end
@implementation HJListTopCell

-(void)setModel:(HJListTopModel *)model
{
    _model=model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    self.abstructLabel.text=model.article_abstract;
    self.topLabel.text=[NSString stringWithFormat:@"TOP %@",model.top];
    self.titleLabel.text=model.article_title;
    self.formLabel.text=model.article_origin;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.width=Width;
    self.labelView.layer.borderColor=RGB(230, 198, 168, 1).CGColor;
    self.labelView.layer.borderWidth=0.5;
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.formLabel.frame)+25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
