//
//  GNRGoodsListCell.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsListCell.h"

@implementation GNRGoodsListCell

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, ([UIColor colorWithWhite:0.8 alpha:0.8]).CGColor);
    CGContextStrokeRect(context, CGRectMake(16, rect.size.height, rect.size.width, 0.4));
}

- (GNRCountStepper *)stepper{
    if (!_stepper) {
        _stepper = [[GNRCountStepper alloc]initWithFrame:CGRectZero];
    }
    return _stepper;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.stepperSuperView addSubview:self.stepper];
    [self.stepper countChangedBlock:^(NSInteger count) {
        if (_goods) {
            _goods.number = @(count);
            if ([_delegate respondsToSelector:@selector(stepper:valueChangedForCount:goods:)]) {
                [_delegate stepper:_stepper valueChangedForCount:count goods:_goods];
            }
        }
    }];
    __weak typeof(self) wself = self;
    [wself.stepper addActionBlock:^(UIButton * btn) {
        if ([wself.delegate respondsToSelector:@selector(stepper:addSender:cell:)]) {
            [wself.delegate stepper:wself.stepper addSender:btn cell:wself];
        }
    }];
    [wself.stepper subActionBlock:^(UIButton * btn) {
        if ([wself.delegate respondsToSelector:@selector(stepper:subSender:cell:)]) {
            [wself.delegate stepper:wself.stepper subSender:btn cell:wself];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoods:(GNRGoodsModel *)goods{
    _goods = goods;
    [self refreshUI];
}

- (void)layoutSubviews{
    self.stepper.center = CGPointMake(_stepperSuperView.bounds.size.width/2.0, _stepperSuperView.bounds.size.height/2.0);
}

- (void)refreshUI{
    if (!_goods) {
        return;
    }
    _nameL.text = _goods.goodsName;
    _priceL.text = [NSString stringWithFormat:@"￥%@",_goods.goodsPrice];
    _stepper.count = _goods.number.integerValue;
}

@end
