//
//  GNRShoppingBag.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShoppingBag.h"

@implementation GNRShoppingBag

- (NSInteger)goodsNumber{
    __block NSInteger number = 0;
    if (_goodsArr.count) {
        [_goodsArr enumerateObjectsUsingBlock:^(GNRGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            number += obj.number.integerValue;
        }];
    }
    return number;
}

- (float)totalPrice{
    __block float price = 0;
    [_goodsArr enumerateObjectsUsingBlock:^(GNRGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        price += obj.goodsPrice.floatValue * obj.number.integerValue;
    }];
    return price;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _goodsArr = [NSMutableArray array];
    }
    return self;
}

//更新购物袋中的商品
- (void)updateGoods:(GNRGoodsModel *)goods{
    NSInteger number = goods.number.integerValue;//购物袋中商品的数量
    if (number>0) {
        if (![_goodsArr containsObject:goods]) {
            [_goodsArr addObject:goods];
        }
    }else{
        if ([_goodsArr containsObject:goods]) {
            [_goodsArr removeObject:goods];
        }
    }
}

//清空购物袋
- (void)clear{
    [_goodsArr enumerateObjectsUsingBlock:^(GNRGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.number = @0;
    }];
    [_goodsArr removeAllObjects];
}

@end
