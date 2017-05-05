//
//  GNRGoodsModel.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsModel.h"

@implementation GNRGoodsModel
- (float)shouldPayMoney{
    return self.goodsPrice.floatValue * self.number.integerValue;
}
@end
