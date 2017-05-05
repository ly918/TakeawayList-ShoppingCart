//
//  GNRShoppingBar.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShoppingBar.h"
#import "GNRGoodsListModel.h"

@interface GNRShoppingBar ()
{
    CGRect SCREEN_BOUNDS;
    CGFloat kHeight_Bar_Default;
}
@property (nonatomic, strong)UIView * parentView;

@end

@implementation GNRShoppingBar

+ (instancetype)barWithStyle:(GNRShoppingBarStyle)style showInView:(UIView *)view{
    GNRShoppingBar * bar = [[GNRShoppingBar alloc]init];
    bar.style = style;
    bar.parentView = view;
    return bar;
}

+ (CGFloat)defaultHeight{
    return 49.f;
}

- (GNRShoppingCartView *)cartView{
    if (!_cartView) {
        _cartView = [[GNRShoppingCartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, SCREEN_BOUNDS.size.height-self.bounds.size.height)];
        [self.parentView insertSubview:_cartView belowSubview:self];
    }
    return _cartView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    SCREEN_BOUNDS = [UIScreen mainScreen].bounds;
}

- (void)layoutSubviews{
    [self resetFrame];
}

- (void)resetFrame{
    self.frame = CGRectMake(0, SCREEN_BOUNDS.size.height-kHeight_Bar_Default, SCREEN_BOUNDS.size.width, kHeight_Bar_Default);
    self.shoppingBarView.frame = CGRectMake(0, 0, SCREEN_BOUNDS.size.width, kHeight_Bar_Default);
}

- (void)installUI{
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    self.layer.borderWidth = 0.4;

    [self resetFrame];
}

- (GNRShoppingBarView *)shoppingBarView{
    if (!_shoppingBarView) {
        _shoppingBarView = [GNRShoppingBarView view];
        [_shoppingBarView.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shoppingBarView.cartBtn addTarget:self action:@selector(shoppingCartAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shoppingBarView];
    }
    return _shoppingBarView;
}

- (void)setStyle:(GNRShoppingBarStyle)style{
    _style = style;
    switch (style) {
        case GNRShoppingBarStyleDefault:
        {
            kHeight_Bar_Default = [GNRShoppingBar defaultHeight];
            [self installUI];
        }
            break;
            
        default:
            break;
    }
}

- (void)setGoodsList:(GNRGoodsListModel *)goodsList{
    _goodsList = goodsList;
    self.cartView.goodsList = goodsList;
    [self reloadData];
}

- (void)reloadData{
    [self refreshCartBar];
    [self.cartView reloadData];
}

- (void)refreshCartBar{
    [self.shoppingBarView updateBadgeValue:_goodsList.shoppingCart.goodsTotalNumber price:_goodsList.shoppingCart.totalPrice];
}

- (void)shoppingCartAction:(id)sender {
    if (!self.goodsList.shoppingCart.goodsTotalNumber) {
        return;
    }
    if (self.cartView.shown) {
        [self.cartView dismiss];
    }else{
        //赋值
        [self.cartView show];
    }
}

- (void)payAction:(id)sender {
    
}

@end
