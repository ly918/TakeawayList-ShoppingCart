//
//  GNRShoppingCart.h
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNRShoppingBag.h"

@interface GNRShoppingCart : NSObject
@property (nonatomic, assign)NSInteger goodsTotalNumber;//购物车商品总数
@property (nonatomic, assign)float totalPrice;
@property (nonatomic, strong)NSMutableArray <GNRShoppingBag *>* bags;//购物袋
- (void)clear;
@end
