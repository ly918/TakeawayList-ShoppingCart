//
//  GNRCountStepper.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRCountStepper.h"

@interface GNRCountStepper ()
{
    CGFloat Height_MAX;
    CGFloat Width_MAX;
    CGFloat Width_Btn;
    CGFloat Width_Lab;
    CGRect BOUNDS_SIZE;
    void(^_block)(NSInteger count);
    void(^_addActionBlock)(UIButton * btn);
    void(^_subActionBlock)(UIButton * btn);
}


@end

@implementation GNRCountStepper

- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self installUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self installUI];
    }
    return self;
}

- (void)initData{
    Width_Btn = 23.f;
    Width_Lab = 30.f;
    Width_MAX = Width_Lab+Width_Btn*2.f;
    Height_MAX = 30.f;
    BOUNDS_SIZE = CGRectMake(0, 0, Width_MAX, Height_MAX);
    self.bounds = BOUNDS_SIZE;
}

- (void)installUI{
    _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_subBtn setImage:[UIImage imageNamed:@"shoplist_stepper_sub_icon"] forState:UIControlStateNormal];
    _subBtn.frame = CGRectMake(0, (Height_MAX-Width_Btn)/2.0, Width_Btn, Width_Btn);
    [_subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subBtn];
    
    _numberL = [[UILabel alloc]initWithFrame:CGRectMake(_subBtn.frame.origin.x+_subBtn.frame.size.width, 0, Width_Lab, Height_MAX)];
    _numberL.textColor = [UIColor blackColor];
    _numberL.textAlignment = NSTextAlignmentCenter;
    _numberL.text = @"1";
    _numberL.font = [UIFont systemFontOfSize:13];
    [self addSubview:_numberL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"shoplist_stepper_add_icon"] forState:UIControlStateNormal];
    _addBtn.frame = CGRectMake(_numberL.frame.origin.x+_numberL.frame.size.width, _subBtn.frame.origin.y, Width_Btn, Width_Btn);
    [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
}

- (void)setStyle:(GNRCountStepperStyle)style{
    _style = style;
    [_subBtn setImage:[UIImage imageNamed:style==GNRCountStepperStyleGoodsList?@"shoplist_stepper_sub_icon":@"shoplist_stepper_subred_icon"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:style==GNRCountStepperStyleGoodsList?@"shoplist_stepper_add_icon":@"shoplist_stepper_addred_icon"] forState:UIControlStateNormal];
}

- (void)setCount:(NSInteger)count{
    _count = count;
    if (count<=0) {
        _subBtn.hidden = YES;
        _numberL.text = @"";
    }else{
        _subBtn.hidden = NO;
        _numberL.text = @(count).stringValue;
    }
}

- (void)countChangedBlock:(void(^)(NSInteger count))block{
    _block = nil;
    _block = [block copy];
}

- (void)addActionBlock:(void (^)(UIButton *))block{
    _addActionBlock = nil;
    _addActionBlock = [block copy];
}

- (void)subActionBlock:(void(^)(UIButton *))block{
    _subActionBlock = nil;
    _subActionBlock = [block copy];
}

- (void)subBtnAction:(id)sender{
    if (_count>0) {
        self.count--;
    }
    if (_block) {
        _block(_count);
    }

    if (_subActionBlock) {
        _subActionBlock(sender);
    }
}

- (void)addBtnAction:(id)sender{
    self.count++;
    if (_block) {
        _block(_count);
    }
    if (_addActionBlock) {
        _addActionBlock(sender);
    }
}

@end
