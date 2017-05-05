//
//  GNRGoodsListModel.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNRGoodsGroup.h"
#import "GNRShoppingCart.h"//购物车

@interface GNRGoodsListModel : NSObject
@property (nonatomic, assign)NSInteger sectionNumber;
@property (nonatomic, strong)NSMutableArray <GNRGoodsGroup *>* goodsGroups;
@property (nonatomic, strong)GNRShoppingCart * shoppingCart;//购物车

@end
