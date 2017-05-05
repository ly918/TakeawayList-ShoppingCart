//
//  GNRCountStepper.h
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNRCartDefine.h"

@interface GNRCountStepper : UIView

@property (nonatomic, strong)UIButton * subBtn;
@property (nonatomic, strong)UIButton * addBtn;
@property (nonatomic, strong)UILabel * numberL;

@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)GNRCountStepperStyle style;
- (void)countChangedBlock:(void(^)(NSInteger count))block;
- (void)addActionBlock:(void(^)(UIButton *))block;
- (void)subActionBlock:(void(^)(UIButton *))block;
@end
