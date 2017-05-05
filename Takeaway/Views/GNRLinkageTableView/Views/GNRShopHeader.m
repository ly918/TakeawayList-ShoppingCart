//
//  GNRShopHeader.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShopHeader.h"

@implementation GNRShopHeader

- (void)layoutSubviews{
    _logoImgV.layer.cornerRadius = _logoImgV.bounds.size.height/2.0;
    _logoImgV.layer.borderColor = [UIColor whiteColor].CGColor;
    _logoImgV.layer.borderWidth = 1;
    _logoImgV.layer.masksToBounds = YES;
}

+ (GNRShopHeader *)header{
    return [[[NSBundle mainBundle]loadNibNamed:@"GNRShopHeader" owner:self options:nil]firstObject];;
}

@end
