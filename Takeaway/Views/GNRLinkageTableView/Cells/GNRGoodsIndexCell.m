//
//  GNRGoodsIndexCell.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsIndexCell.h"
#import "GNRGoodsGroup.h"

@interface GNRGoodsIndexCell ()
@property (nonatomic, strong)UIView * selectView;

@end

@implementation GNRGoodsIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _selectView = [[UIView alloc]initWithFrame:self.bounds];
    _selectView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = _selectView;
    
    UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 4, 13)];
    liner.backgroundColor = _nameL.textColor;
    [_selectView addSubview:liner];
    liner.center = CGPointMake(2, _nameL.center.y);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.nameL.font = selected?[UIFont boldSystemFontOfSize:15]:[UIFont systemFontOfSize:13];
}

- (void)setGoodsGroup:(GNRGoodsGroup *)goodsGroup{
    _goodsGroup = goodsGroup;
    [self refreshUI];
}

- (void)refreshUI{
    if (_goodsGroup) {
        self.nameL.text = _goodsGroup.classesName;
    }
}

@end
