//
//  HJMeOrderCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/12.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJMeOrderCell.h"
#import "HJToolButton.h"
@interface HJMeOrderCell ()
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSArray *textArr;

@end
@implementation HJMeOrderCell
-(NSArray *)imgArr
{
    if (!_imgArr) {
        _imgArr=[NSArray array];
    }
    return _imgArr;
}
-(NSArray *)textArr
{
    if (!_textArr) {
        _textArr=[NSArray array];
    }
    return _textArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellInitWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"orderCell";
    HJMeOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[HJMeOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgArr=@[@"mine_payment",@"mine_delivery",@"mine_sendgoods",@"mine_evaluation",@"mine_refund"];
        self.textArr=@[@"代付款",@"代发货",@"待收货",@"待评价",@"退货"];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UILabel *myOrderLabel=[[UILabel alloc]init];
    myOrderLabel.text=@"我的订单";
    [self.contentView addSubview:myOrderLabel];
    
    UIImageView *goin = [[UIImageView alloc] init];
    goin.image = [UIImage imageNamed:@"btn_in"];
    [self.contentView addSubview:goin];
    
    UILabel *seeAlllabel = [[UILabel alloc] init];
    seeAlllabel.text = @"查看全部";
    seeAlllabel.font = [UIFont systemFontOfSize:14];
    seeAlllabel.textColor = [UIColor lightGrayColor];
    seeAlllabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:seeAlllabel];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    myOrderLabel.sd_layout.topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10).widthIs(100).heightIs(20);
    goin.sd_layout.topSpaceToView(self.contentView,13).rightSpaceToView(self.contentView,20).widthIs(6).heightIs(14);
    seeAlllabel.sd_layout.topEqualToView(myOrderLabel).rightSpaceToView(goin,10).widthIs(100).heightIs(20);
    line.sd_layout.topSpaceToView(myOrderLabel,10).leftEqualToView(myOrderLabel).rightSpaceToView(self.contentView,10).heightIs(0.5);
    
    CGFloat btnWidth=Width/self.imgArr.count;
    for (int i=0; i<self.imgArr.count; i++) {
        HJToolButton *btn=[HJToolButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i;
        [btn setImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
        [btn setTitle:self.textArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBasketBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:btn];
        
        btn.sd_layout.topSpaceToView(line,10).leftSpaceToView(self.contentView,i*btnWidth).widthIs(btnWidth).heightIs(btnWidth);
    }
}
-(void)clickBasketBtn:(HJToolButton *)btn
{
    
}
@end
