//
//  GNRShoppingCartView.h
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNRCartHeader.h"
#import "GNRCartFooter.h"
@class  GNRGoodsListModel;

@interface GNRShoppingCartView : UIView
@property (nonatomic, assign)BOOL shown;
@property (nonatomic, weak)id target;
@property (nonatomic, strong)GNRGoodsListModel * goodsList;
@property (nonatomic, strong)GNRCartHeader * header;
@property (nonatomic, strong)GNRCartFooter * footer;
@property (nonatomic, strong)UITableView * tableView;

- (void)show;
- (void)dismiss;
- (void)reloadData;

@end
