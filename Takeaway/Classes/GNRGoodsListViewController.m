//
//  GNRGoodsListViewController.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRGoodsListViewController.h"
#import "UINavigationBar+Awesome.h"
#import "GNRLinkageTableView.h"
#import "GNRShoppingBar.h"

@interface GNRGoodsListViewController ()<GNRGoodsNumberChangedDelegate,GNRLinkageTableViewDelegate,CAAnimationDelegate>

@property (nonatomic,strong) CALayer *dotLayer;//小圆点
@property (nonatomic,assign) CGFloat endPointX;
@property (nonatomic,assign) CGFloat endPointY;
@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic, strong)GNRLinkageTableView * goodsListView;
@property (nonatomic, strong)GNRShoppingBar * shoppingBar;
@end

@implementation GNRGoodsListViewController

- (void)dealloc{
    NSLog(@"dealloc");
}

- (GNRLinkageTableView *)goodsListView{
    if (!_goodsListView) {
        _goodsListView = [[GNRLinkageTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-[GNRShoppingBar defaultHeight])];
        _goodsListView.target = self;
        _goodsListView.delegate = self;
    }
    return _goodsListView;
}

- (GNRShoppingBar *)shoppingBar{
    if (!_shoppingBar) {
        _shoppingBar = [GNRShoppingBar barWithStyle:GNRShoppingBarStyleDefault showInView:self.view];
        _shoppingBar.cartView.target = self;
        [_shoppingBar.cartView.header.cleanBtn addTarget:self action:@selector(cleanGoodsCartAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect rect = [self.view convertRect:_shoppingBar.shoppingBarView.shoppingCartIcon.frame fromView:_shoppingBar.shoppingBarView];
        
        _endPointX = rect.origin.x + rect.size.width/2.0;
        _endPointY = rect.origin.y + rect.size.height/2.0;
    }
    return _shoppingBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.goodsListView];
    [self initData];
    [self.view addSubview:self.shoppingBar];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScrollForPositionY:self.goodsListView.rightTbView.contentOffset.y];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar lt_reset];
}

- (void)initData{
    NSArray * arr = @[
                      @{@"title" : @"精选特卖",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤", @"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title" : @"饭后(含有茶点)",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title" : @"茶点(含有茶点)",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title" : @"素材水果拼盘",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤",]
                        },
                      @{@"title" : @"水果拼盘生鲜果",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤",]
                        },
                      @{@"title" : @"拼盘",
                        @"list" : @[@"甜点组合"]
                        },
                      @{@"title" : @"烤鱼盘",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title" : @"饮料",
                        @"list": @[@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤",@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title": @"小吃",
                        @"list": @[@"甜点组合", @"毛肚"]
                        },
                      @{@"title" : @"作料",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      @{@"title" : @"主食",
                        @"list" : @[@"甜点组合", @"毛肚", @"菌汤"]
                        },
                      ];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GNRGoodsGroup * goodsGroup = [GNRGoodsGroup new];
        goodsGroup.classesName = [obj objectForKey:@"title"];
        NSArray * list = [obj objectForKey:@"list"];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GNRGoodsModel * goods = [GNRGoodsModel new];
            goods.goodsName = obj;
            goods.goodsPrice = [NSString stringWithFormat:@"%.2f",(float)arc4random_uniform(100)+50.f];
            [goodsGroup.goodsList addObject:goods];
        }];
        [_goodsListView.goodsList.goodsGroups addObject:goodsGroup];
    }];
    [_goodsListView reloadData];

    self.shoppingBar.goodsList = _goodsListView.goodsList;
}

- (void)scrollViewDidScrollForPositionY:(CGFloat)y{
    if (y<=64.f) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:y/64.f]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

//clean
- (void)cleanGoodsCartAction:(id)sender{
    [self.goodsListView.goodsList.shoppingCart clear];
    [self.shoppingBar.cartView dismiss];
    [self.shoppingBar refreshCartBar];
    [self.goodsListView.rightTbView reloadData];
}

#pragma mark - stepper delegate
- (void)stepper:(GNRCountStepper *)stepper valueChangedForCount:(NSInteger)count goods:(GNRGoodsModel *)goods{
    if (stepper.style == GNRCountStepperStyleGoodsList) {
        //更新购物车中的商品
        [self.goodsListView.goodsList.shoppingCart.bags.firstObject updateGoods:goods];
        //更新badgeValue
        [self.shoppingBar reloadData];
    }else{//购物车中的
        if (count==0) {
            [self.goodsListView.goodsList.shoppingCart.bags.firstObject updateGoods:goods];
        }
        [self.goodsListView.rightTbView reloadData];
        if (!self.goodsListView.goodsList.shoppingCart.goodsTotalNumber) {
            [self.shoppingBar.cartView dismiss];
            [self.shoppingBar refreshCartBar];
        }else{
            [self.shoppingBar reloadData];
        }
    }
}

- (void)stepper:(GNRCountStepper *)stepper addSender:(UIButton *)sender cell:(UITableViewCell *)cell{
    CGRect parentRect = [stepper convertRect:stepper.addBtn.frame toView:self.view];
    [self jumpToCartAnimationWithAddBtnRect:parentRect];
}

#pragma mark - 跳入购物车动画
-(void)jumpToCartAnimationWithAddBtnRect:(CGRect)rect{
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor blackColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 14, 14);
    _dotLayer.cornerRadius = 14/2.f;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
}

#pragma mark - 开始组合动画
-(void)groupAnimation{
    //路径
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    //alpha
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.35f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.6f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.6f];
}

//移除layer
- (void)removeFromLayer:(CALayer *)layerAnimation{
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
//组合动画结束后 购物车 缩放动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.1f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:1];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1.2];
        shakeAnimation.autoreverses = YES;
        [_shoppingBar.shoppingBarView.shoppingCartIcon.layer addAnimation:shakeAnimation forKey:nil];
    }
}

@end
