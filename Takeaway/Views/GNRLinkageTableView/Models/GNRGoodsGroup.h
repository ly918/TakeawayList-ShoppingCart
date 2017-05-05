//
//  GNRGoodsGroup.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNRGoodsModel.h"

@interface GNRGoodsGroup : NSObject
@property (nonatomic, strong)NSString * classesName;//分类
@property (nonatomic, strong)NSMutableArray <GNRGoodsModel *>* goodsList;
@end
