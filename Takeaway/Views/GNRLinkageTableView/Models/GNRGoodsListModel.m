//
//  GNRGoodsListModel.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsListModel.h"

@implementation GNRGoodsListModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _goodsGroups = [NSMutableArray array];
        _shoppingCart = [GNRShoppingCart new];
    }
    return self;
}

- (NSInteger)sectionNumber{
    return self.goodsGroups.count;
}

- (void)setGoodsGroups:(NSMutableArray<GNRGoodsGroup *> *)goodsGroups{
    _goodsGroups = goodsGroups;
    //初始化
    [_goodsGroups enumerateObjectsUsingBlock:^(GNRGoodsGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.goodsList enumerateObjectsUsingBlock:^(GNRGoodsModel * _Nonnull goods, NSUInteger goodsIdx, BOOL * _Nonnull stop) {
            if (goods.number.integerValue) {//数量>0则加入购物袋
                [_shoppingCart.bags.firstObject updateGoods:goods];
            }
        }];
    }];
}

@end
