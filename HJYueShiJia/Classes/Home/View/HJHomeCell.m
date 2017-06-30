//
//  HJHomeCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJHomeCell.h"
#import "UIImageView+WebCache.h"
@interface HJHomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end
@implementation HJHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width=Width;
    self.priceBtn.layer.borderWidth = 0.5;
    self.priceBtn.layer.borderColor = RGB(211, 192, 162, 1.0f).CGColor;
    
    self.priceBtn.layer.cornerRadius = 5.0;
    self.likeBtn.layer.borderWidth = 0.5;
    self.likeBtn.layer.borderColor = RGB(211, 192, 162, 1.0f).CGColor;
    self.likeBtn.layer.cornerRadius = 5.0;
}
-(void)setHomeCellModel:(HJHomeCellModel *)homeCellModel
{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:homeCellModel.relation_object_image]];
    
    self.nameLabel.text=homeCellModel.relation_object_title;
    self.descLabel.text=homeCellModel.relation_object_jingle;
    [self.priceBtn setTitle:[NSString stringWithFormat:@"$ %@",homeCellModel.goods_price] forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.descLabel.frame)+35;
}
- (IBAction)touchLike:(UIButton *)sender {
}

@end
