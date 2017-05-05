//
//  GNRShoppingCart.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShoppingCart.h"

@implementation GNRShoppingCart

- (NSInteger)goodsTotalNumber{
    __block NSInteger number = 0;
    if (_bags.count) {
        [_bags enumerateObjectsUsingBlock:^(GNRShoppingBag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            number += obj.goodsNumber;
        }];
    }
    return number;
}

- (float)totalPrice{
    __block float price = 0;
    if (_bags.count) {
        [_bags enumerateObjectsUsingBlock:^(GNRShoppingBag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            price += obj.totalPrice;
        }];
    }
    return price;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //暂时只生成一个购物袋
        GNRShoppingBag * bag = [GNRShoppingBag new];
        bag.identifer = @"1";
        _bags = [NSMutableArray arrayWithObjects:bag, nil];
    }
    return self;
}

- (void)clear{
    [self.bags enumerateObjectsUsingBlock:^(GNRShoppingBag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj clear];
    }];
}

@end
