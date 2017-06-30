//
//  HJVideoCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJVideoCell.h"

@interface HJVideoCell()

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end
@implementation HJVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setVideoModel:(HJVideoModel *)videoModel
{
    _videoModel=videoModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:videoModel.article_image]];
    self.timeLabel.text = videoModel.video_length;
    self.titleLabel.text = videoModel.article_title;
    self.descLabel.text = videoModel.article_abstract;
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.descLabel.frame) + 25;
}
- (IBAction)touchPlay:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchPlay:)]) {
        [self.delegate touchPlay:self];
    }
}
@end
