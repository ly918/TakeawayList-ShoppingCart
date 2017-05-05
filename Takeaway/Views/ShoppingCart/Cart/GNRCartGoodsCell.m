//
//  GNRCartGoodsCell.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRCartGoodsCell.h"
#import "GNRGoodsModel.h"
@implementation GNRCartGoodsCell


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, ([UIColor colorWithWhite:0.8 alpha:0.8]).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.4));
}

- (GNRCountStepper *)stepper{
    if (!_stepper) {
        _stepper = [[GNRCountStepper alloc]initWithFrame:CGRectZero];
        _stepper.style = GNRCountStepperStyleShoppingCart;
    }
    return _stepper;
}

- (void)config:(GNRGoodsModel *)goods{
     [self.stepperSuperView addSubview:self.stepper];
    [self.stepper countChangedBlock:^(NSInteger count) {
        if (goods) {
            goods.number = @(count);
            _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",goods.shouldPayMoney];
            if ([_delegate respondsToSelector:@selector(stepper:valueChangedForCount:goods:)]) {
                [_delegate stepper:_stepper valueChangedForCount:count goods:goods];
            }
        }
    }];
    self.stepper.count = goods.number.integerValue;
    self.nameL.text = goods.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",goods.shouldPayMoney];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    self.stepper.center = CGPointMake(_stepperSuperView.bounds.size.width/2.0, _stepperSuperView.bounds.size.height/2.0);
}

@end
