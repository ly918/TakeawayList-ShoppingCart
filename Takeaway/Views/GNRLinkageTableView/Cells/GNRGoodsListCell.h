//
//  GNRGoodsListCell.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNRCartDefine.h"


@interface GNRGoodsListCell : UITableViewCell
@property (weak, nonatomic) id<GNRGoodsNumberChangedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIView *stepperSuperView;
@property (strong, nonatomic)GNRCountStepper * stepper;
@property (strong, nonatomic)GNRGoodsModel * goods;

@end
