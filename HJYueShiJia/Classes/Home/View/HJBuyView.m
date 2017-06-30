//
//  HJBuyView.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/1.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBuyView.h"

@interface HJBuyView ()
@property (nonatomic, assign) NSInteger num;

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *origLabel;
@property (nonatomic, weak) UILabel *numberLabel;
@property (nonatomic, weak) UIButton *minusBtn;


@end
@implementation HJBuyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.num=1;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    UIView *backgroudView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchbegen)];
    [backgroudView addGestureRecognizer:tap];
    backgroudView.backgroundColor=[UIColor blackColor];
    backgroudView.alpha=0.3;
    [self addSubview:backgroudView];
    
    UIView *goodsView=[[UIView alloc]init];
    goodsView.backgroundColor=[UIColor whiteColor];
    [self addSubview:goodsView];
    
    UIImageView *imageView=[[UIImageView alloc]init];
    [goodsView addSubview:imageView];
    self.imgView=imageView;
    
    UILabel *nameLabel=[[UILabel alloc]init];
    [goodsView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UILabel *priceLabel=[[UILabel alloc]init];
    priceLabel.textColor=[UIColor redColor];
    [goodsView addSubview:priceLabel];
    self.priceLabel=priceLabel;
    
    UILabel *origLabel=[[UILabel alloc]init];
    origLabel.textColor=[UIColor lightGrayColor];
    origLabel.font=[UIFont systemFontOfSize:13];
    [goodsView addSubview:origLabel];
    self.origLabel=origLabel;
    
    UILabel *numLabel=[[UILabel alloc]init];
    numLabel.text=@"数量：";
    [goodsView addSubview:numLabel];
    
    UIButton *minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [minusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    minusBtn.layer.borderColor=RGB(230, 198, 168, 1).CGColor;
    minusBtn.layer.borderWidth=0.5;
    [minusBtn addTarget:self action:@selector(minusTouch) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:minusBtn];
    self.minusBtn=minusBtn;
    
    UILabel *numberLabel=[[UILabel alloc]init];
    numberLabel.text=@"1";
    numberLabel.textAlignment=NSTextAlignmentCenter;
    numberLabel.textColor=[UIColor lightGrayColor];
    numberLabel.layer.borderColor=RGB(230, 198, 168, 1).CGColor;
    numberLabel.layer.borderWidth=0.5;
    [goodsView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addBtn.layer.borderColor=RGB(230, 198, 168, 1).CGColor;
    addBtn.layer.borderWidth=0.5;
    [addBtn addTarget:self action:@selector(addTouch) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:addBtn];
    
    UIButton *doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor=RGB(230, 198, 168, 1);
    [doneBtn addTarget:self action:@selector(doneTouch) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:doneBtn];
    
    goodsView.sd_layout.leftEqualToView(self).bottomEqualToView(self).rightEqualToView(self).heightIs(self.height*0.4);
    imageView.sd_layout.leftSpaceToView(goodsView,10).topSpaceToView(goodsView,-10).widthIs(Width*0.3).heightIs(Width*0.3);
    nameLabel.sd_layout.leftSpaceToView(imageView,12).topSpaceToView(goodsView,12).rightSpaceToView(goodsView,10).autoHeightRatio(0);
    priceLabel.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel,16).widthIs(80).heightIs(20);
    origLabel.sd_layout.leftSpaceToView(priceLabel,8).topEqualToView(priceLabel).widthIs(80).heightIs(20);
    numLabel.sd_layout.leftEqualToView(imageView).topSpaceToView(imageView,30).widthIs(60).heightIs(20);
    minusBtn.sd_layout.leftEqualToView(numLabel).topSpaceToView(numLabel,15).widthIs(50).heightIs(30);
    numberLabel.sd_layout.leftSpaceToView(minusBtn,0).topEqualToView(minusBtn).widthIs(50).heightIs(30);
    addBtn.sd_layout.leftSpaceToView(numberLabel,0).topEqualToView(numberLabel).widthIs(50).heightIs(30);
    doneBtn.sd_layout.leftEqualToView(goodsView).bottomEqualToView(goodsView).rightEqualToView(goodsView).heightIs(44);
    
}
-(void)setGoodsModel:(HJGoodsModel *)goodsModel
{
    self.nameLabel.text=goodsModel.goodsName;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",goodsModel.goodsPrice];
    self.origLabel.attributedText=[UILabel midLineWithString:[NSString stringWithFormat:@"¥%@",goodsModel.goodsOrigPrice]];
}
-(void)setImageStr:(NSString *)imageStr
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}
-(void)minusTouch
{
    if (self.num<=1) {
        self.numberLabel.text=@"1";
        self.minusBtn.selected=NO;
    }else
    {
        self.numberLabel.text=[NSString stringWithFormat:@"%ld",--self.num];
    }
}
-(void)addTouch
{
    self.numberLabel.text=[NSString stringWithFormat:@"%ld",++self.num];
}
-(void)doneTouch
{
    if ([self.delegate respondsToSelector:@selector(touchDoneWith:ImageView:)]) {
        [self.delegate touchDoneWith:self.num ImageView:self.imgView];
    }
}
-(void)touchbegen
{
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden=YES;
        self.numberLabel.text=@"1";
    }];
}
@end
