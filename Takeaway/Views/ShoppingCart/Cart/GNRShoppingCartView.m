//
//  GNRShoppingCartView.m
//  外卖
//
//  Created by LvYuan on 2017/5/3.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShoppingCartView.h"
#import "GNRCartGoodsCell.h"
#import "GNRGoodsListModel.h"

@interface GNRShoppingCartView ()<UITableViewDelegate,UITableViewDataSource>
{
    CGRect BOUNDS;
    CGFloat Height_Cell;
    CGFloat Height_Header;
    CGFloat Height_Footer;
    CGFloat Height_Max;
    CGFloat Height_TB;
    CGFloat Height_Default;
    CGFloat kDuration;
}
@property (nonatomic, strong)UIView * bgView;
@property (nonatomic, strong)UIView * contentView;
@end

@implementation GNRShoppingCartView

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressAction:)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)tapPressAction:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self dismiss];
    }
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, BOUNDS.size.height, BOUNDS.size.width, Height_Default)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (GNRCartHeader *)header{
    if (!_header) {
        _header = [[[NSBundle mainBundle]loadNibNamed:@"GNRCartHeader" owner:self options:nil]firstObject];
        _header.frame = CGRectMake(0, 0, BOUNDS.size.width, Height_Header);
        
    }
    return _header;
}

- (GNRCartFooter *)footer{
    if (!_footer) {
        _footer = [[[NSBundle mainBundle]loadNibNamed:@"GNRCartFooter" owner:self options:nil]firstObject];
        _footer.frame = CGRectMake(0, self.tableView.frame.origin.y+self.tableView.frame.size.height, BOUNDS.size.width, Height_Footer);
    }
    return _footer;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bounds.size.height, BOUNDS.size.width, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self installUI];
    }
    return self;
}

- (void)initData{
    self.hidden = YES;
    kDuration = 0.3;
    Height_Header = 32.f;
    Height_Footer = 26.f;
    Height_Cell = 50;
    BOUNDS = self.bounds;
    Height_Max = BOUNDS.size.height * 0.56;
    [self resizeHeight_TB];
    Height_Default = Height_Header + Height_Footer + Height_TB;
}

- (void)resizeHeight_TB{
    Height_TB = [[[self.goodsList.shoppingCart.bags firstObject] goodsArr] count] * Height_Cell;
    if (Height_TB>Height_Max) {
        Height_TB = Height_Max;
    }
}

- (void)installUI{
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.footer];
}

- (void)reloadData{
    [self.tableView reloadData];
    [self resetFrameAnimation];
}

- (void)resetFrameAnimation{
    [self resizeHeight_TB];

    CGRect headerFrame = self.header.frame;
    headerFrame.origin.y = 0;
    
    CGRect footerFrame = self.footer.frame;
    footerFrame.origin.y = Height_TB + Height_Header;
    
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin.y = BOUNDS.size.height - Height_TB-Height_Footer-Height_Header;
    contentFrame.size.height = Height_TB+Height_Footer+Height_Header;
    
    CGRect tbFrame = self.tableView.frame;
    tbFrame.origin.y = Height_Header;
    tbFrame.size.height = Height_TB;
    
    [UIView animateWithDuration:kDuration delay:0.01 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = contentFrame;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:kDuration delay:0.01 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.header.frame = headerFrame;
        self.tableView.frame = tbFrame;
        self.footer.frame = footerFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show{
    _shown = YES;
    self.hidden = NO;

    [UIView animateWithDuration:kDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    } completion:^(BOOL finished) {
        
    }];
    
    [self reloadData];
}


- (void)dismiss{
    _shown = NO;
    [UIView animateWithDuration:kDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, BOUNDS.size.height, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.goodsList.shoppingCart.bags.firstObject goodsArr] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GNRCartGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GNRCartGoodsCell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GNRCartGoodsCell" owner:self options:nil]firstObject];
    }
    GNRGoodsModel * goods = [self.goodsList.shoppingCart.bags.firstObject goodsArr][indexPath.row];
    cell.delegate = _target;//交给controller处理
    [cell config:goods];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height_Cell;
}

@end
