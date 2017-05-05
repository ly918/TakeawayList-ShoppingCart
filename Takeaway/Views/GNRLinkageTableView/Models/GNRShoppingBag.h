//
//  GNRShoppingBag.h
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNRGoodsModel.h"
@interface GNRShoppingBag : NSObject

@property (nonatomic, copy)NSString * identifer;//购物袋编号
@property (nonatomic, assign)NSInteger goodsNumber;//购物袋商品数
@property (nonatomic, assign)float totalPrice;
@property (nonatomic, strong)NSMutableArray <GNRGoodsModel *>* goodsArr;//商品

//更新购物袋中的商品
- (void)updateGoods:(GNRGoodsModel *)goods;
- (void)clear;

@end
