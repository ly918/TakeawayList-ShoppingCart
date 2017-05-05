//
//  GNRCartFooter.m
//  外卖
//
//  Created by LvYuan on 2017/5/4.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRCartFooter.h"

@implementation GNRCartFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect{
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    self.layer.borderWidth = 0.4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
