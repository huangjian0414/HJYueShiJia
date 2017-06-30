//
//  HJMeAccountCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/12.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJMeAccountCell.h"
#import "HJToolButton.h"
@interface HJMeAccountCell ()
@property (nonatomic, strong) NSArray *numArr;
@property (nonatomic, strong) NSArray *textArr;

@end
@implementation HJMeAccountCell
- (NSArray *)numArr
{
    if (!_numArr) {
        _numArr = [NSArray array];
    }
    return _numArr;
}

- (NSArray *)textArr
{
    if (!_textArr) {
        _textArr = [NSArray array];
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
    HJMeAccountCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[HJMeAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.numArr=@[@"0.00",@"0",@"20"];
        self.textArr=@[@"余额",@"代金券",@"积分"];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UILabel *myAccountLabel = [[UILabel alloc] init];
    myAccountLabel.text = @"我的账户";
    [self.contentView addSubview:myAccountLabel];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    myAccountLabel.sd_layout.topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10).widthIs(100).heightIs(20);
    line.sd_layout.topSpaceToView(myAccountLabel,10).leftEqualToView(myAccountLabel).rightSpaceToView(self.contentView,10).heightIs(0.5);
    
    CGFloat btnWidth=Width/self.textArr.count;
    for (int i=0; i<self.textArr.count; i++) {
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.text = self.numArr[i];
        numLabel.font = [UIFont systemFontOfSize:17.0];
        numLabel.textColor = RGB(230, 198, 168, 1);
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:numLabel];
        
        numLabel.sd_layout.topSpaceToView(line,10).leftSpaceToView(self.contentView,i*btnWidth).widthIs(btnWidth).heightIs(44);
        
        UILabel *textLabel=[[UILabel alloc]init];
        textLabel.text = self.textArr[i];
        textLabel.font = [UIFont systemFontOfSize:14.0];
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
        
        textLabel.sd_layout.topSpaceToView(numLabel,5).leftEqualToView(numLabel).widthIs(btnWidth).heightIs(20);
    }
}
@end
