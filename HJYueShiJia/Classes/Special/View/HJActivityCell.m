//
//  HJActivityCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJActivityCell.h"

@interface HJActivityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end
@implementation HJActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HJActivityModel *)model
{
    _model=model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.endLabel.text=model.end_virtual;
    self.nameLabel.text=model.goods_name;
    self.hintLabel.text=model.hint_virtual;
}

-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.imgView.frame)+ 20;
}
@end
