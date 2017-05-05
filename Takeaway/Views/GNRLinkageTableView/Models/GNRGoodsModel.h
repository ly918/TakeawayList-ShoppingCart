//
//  GNRGoodsModel.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNRGoodsModel : NSObject

@property (nonatomic, strong)NSString * goodsName;
@property (nonatomic, strong)NSString * goodsImage;
@property (nonatomic, strong)NSString * goodsPrice;
@property (nonatomic, assign)float shouldPayMoney;
@property (nonatomic, strong)NSNumber * number;//购买个数

@end
