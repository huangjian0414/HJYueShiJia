//
//  HJStoreCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJStoreCell.h"

@interface HJStoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end
@implementation HJStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.width=Width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HJStoreCellModel *)model
{
    _model=model;
    self.titleLabel.text=model.special_title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.special_image]];
    
}

- (CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.imgView.frame)+15;
}
@end
