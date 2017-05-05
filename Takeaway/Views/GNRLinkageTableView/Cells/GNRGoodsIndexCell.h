//
//  GNRGoodsIndexCell.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GNRGoodsGroup;
@interface GNRGoodsIndexCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (strong, nonatomic) GNRGoodsGroup * goodsGroup;
@end
