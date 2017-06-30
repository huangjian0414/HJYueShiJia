//
//  HJVideoCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJVideoModel.h"

@class HJVideoCell;
@protocol HJVideoCellDelegate <NSObject>

-(void)touchPlay:(HJVideoCell *)videoCell;

@end
@interface HJVideoCell : UITableViewCell
@property (nonatomic,strong)HJVideoModel *videoModel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,weak)id<HJVideoCellDelegate>delegate;

@property (nonatomic,strong)NSIndexPath *index;
-(CGFloat)getCellHeight;
@end
