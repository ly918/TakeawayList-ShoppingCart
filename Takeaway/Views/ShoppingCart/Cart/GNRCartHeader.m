//
//  GNRCartHeader.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRCartHeader.h"

@implementation GNRCartHeader

- (void)drawRect:(CGRect)rect{
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    self.layer.borderWidth = 0.4;
}

@end
