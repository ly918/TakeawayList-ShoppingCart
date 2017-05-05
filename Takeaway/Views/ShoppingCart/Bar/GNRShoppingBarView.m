//
//  GNRShoppingBarView.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShoppingBarView.h"

@implementation GNRShoppingBarView

+ (GNRShoppingBarView *)view{
    return (GNRShoppingBarView *)[[[NSBundle mainBundle]loadNibNamed:@"GNRShoppingBarView" owner:self options:nil]firstObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.badgeLabel.center = CGPointMake(_shoppingCartIcon.frame.origin.x+_shoppingCartIcon.frame.size.width, _shoppingCartIcon.frame.origin.y);

    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    self.shoppingCartSuperView.layer.borderColor =[UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    self.shoppingCartSuperView.layer.borderWidth = 0.4;
    _badgeLabel.layer.cornerRadius = _badgeLabel.bounds.size.height/2.0;
    _badgeLabel.layer.masksToBounds = YES;
}

- (void)updateBadgeValue:(NSInteger)value price:(float)price{
    //badge
    self.badgeLabel.hidden = !value;
    self.badgeLabel.text = @(value).stringValue;
    NSInteger maxCount = 5;
    CGFloat textW = 6.f;
    CGFloat maxW = maxCount * textW;
    CGFloat labW = (self.badgeLabel.text.length + 1.f) * textW;
    CGFloat minW = 14.f;
    if (labW>maxW) {
        labW = maxW;
    }else if (labW<minW){
        labW = minW;
    }
    //peice
    self.badgeLabel.bounds = CGRectMake(0, 0, labW, minW);
    NSString * priceStr =[NSString stringWithFormat:@"商品共%.2f元",price];
    self.priceL.text = value?priceStr:@"购物车为空";
    //btn
    self.payBtn.backgroundColor = price?[UIColor blackColor]:[UIColor lightGrayColor];
    self.payBtn.enabled = price;
}

@end
