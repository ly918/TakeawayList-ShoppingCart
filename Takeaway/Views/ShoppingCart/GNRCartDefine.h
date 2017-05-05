
//
//  GNRCartDefine.h
//  外卖
//
//  Created by LvYuan on 2017/5/4.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#ifndef GNRCartDefine_h
#define GNRCartDefine_h

#import "GNRGoodsListModel.h"
@class GNRCountStepper;

//stepper风格
typedef NS_ENUM(NSInteger,GNRCountStepperStyle) {
    GNRCountStepperStyleGoodsList,//商品列表中的
    GNRCountStepperStyleShoppingCart,//购物车中的
};

//购物栏风格
typedef NS_ENUM(NSInteger, GNRShoppingBarStyle) {
    GNRShoppingBarStyleDefault,
};

@protocol GNRGoodsNumberChangedDelegate <NSObject>

- (void)stepper:(GNRCountStepper *)stepper valueChangedForCount:(NSInteger)count goods:(GNRGoodsModel *)goods;

- (void)stepper:(GNRCountStepper *)stepper addSender:(UIButton *)sender cell:(UITableViewCell *)cell;

- (void)stepper:(GNRCountStepper *)stepper subSender:(UIButton *)sender cell:(UITableViewCell *)cell;

@end

#import "GNRCountStepper.h"
#import "GNRShoppingCartView.h"

#endif /* GNRCartDefine_h */
