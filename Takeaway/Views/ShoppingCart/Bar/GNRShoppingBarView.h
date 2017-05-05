//
//  GNRShoppingBarView.h
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNRShoppingBarView : UIView

@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIView *shoppingCartSuperView;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingCartIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;

+ (GNRShoppingBarView *)view;

- (void)updateBadgeValue:(NSInteger)value price:(float)price;

@end
