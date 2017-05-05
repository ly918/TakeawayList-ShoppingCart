//
//  GNRGoodsGroup.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsGroup.h"

@implementation GNRGoodsGroup
- (instancetype)init{
    self = [super init];
    if (self) {
        _goodsList = [NSMutableArray array];
    }
    return self;
}
@end
