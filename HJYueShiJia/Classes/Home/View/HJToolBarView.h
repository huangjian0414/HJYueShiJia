//
//  HJToolBarView.h
//  HJYueShiJia
//
//  Created by huangjian on 17/4/26.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJToolBarDelegate <NSObject>

-(void)touchAddBasket;
-(void)touchStore;
-(void)touchBasket;
@end
@interface HJToolBarView : UIView
@property (nonatomic,weak)id<HJToolBarDelegate>delegate;
@end
