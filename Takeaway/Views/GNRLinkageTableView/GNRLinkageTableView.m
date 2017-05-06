//
//  GNRLinkageTableView.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRLinkageTableView.h"
#import "GNRShopHeader.h"
#import "GNRSectionHeader.h"
#import "GNRGoodsIndexCell.h"

@interface GNRLinkageTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL relate;
    BOOL topCanChange;//是否可以渐变
    CGFloat NavBarHeight;
    CGFloat headerHeight;
    CGFloat ChangedHeight;
    
    CGFloat leftWidth;
    CGFloat rightWidth;
    CGRect BOUNDS;
}
@property (nonatomic, strong)GNRShopHeader * header;
@end

@implementation GNRLinkageTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self installTableView];
    }
    return self;
}

- (GNRShopHeader *)header{
    if (!_header) {
        _header = [GNRShopHeader header];
        [self addSubview:_header];
    }
    return _header;
}

- (void)initData{
    relate = YES;
    NavBarHeight = 64.f;
    headerHeight = 152.f;
    ChangedHeight = headerHeight - NavBarHeight;
    _goodsList = [GNRGoodsListModel new];
    BOUNDS = self.bounds;
    leftWidth = 100;
    rightWidth = BOUNDS.size.width - leftWidth;
    
}

- (void)reloadData{
    [_leftTbView reloadData];
    [_rightTbView reloadData];
    [self resetFrame];
}

- (void)resetFrame{
    if (_rightTbView.contentSize.height-_rightTbView.bounds.size.height>=ChangedHeight) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height+ChangedHeight);
        _rightTbView.frame = CGRectMake(leftWidth, headerHeight, rightWidth, BOUNDS.size.height-headerHeight+ChangedHeight);
        topCanChange = YES;
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
        _rightTbView.frame = CGRectMake(leftWidth, headerHeight, rightWidth, BOUNDS.size.height-headerHeight);
        topCanChange = NO;
    }
    _leftTbView.frame = CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-headerHeight);
    self.header.frame = CGRectMake(0, 0, BOUNDS.size.width, headerHeight);
}

- (void)installTableView{
//haeder
    self.header.frame = CGRectMake(0, 0, BOUNDS.size.width, headerHeight);
    
    _leftTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-headerHeight+ChangedHeight) style:UITableViewStylePlain];
    _leftTbView.delegate = self;
    _leftTbView.dataSource = self;
    _leftTbView.showsVerticalScrollIndicator = NO;
    _leftTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTbView = [[UITableView alloc]initWithFrame:CGRectMake(leftWidth, headerHeight, rightWidth, BOUNDS.size.height-headerHeight+ChangedHeight) style:UITableViewStylePlain];
    _rightTbView.delegate = self;
    _rightTbView.dataSource = self;
    [self addSubview:_leftTbView];
    [self addSubview:_rightTbView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_leftTbView) {
        return 1;
    }
    return self.goodsList.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTbView) {
        return self.goodsList.sectionNumber;
    }
    if (section<self.goodsList.goodsGroups.count) {
        GNRGoodsGroup * goodsGroup = self.goodsList.goodsGroups[section];
        return [goodsGroup.goodsList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTbView) {
        GNRGoodsIndexCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GNRGoodsIndexCell"];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"GNRGoodsIndexCell" owner:self options:nil] firstObject];
        }
        if (indexPath.row<self.goodsList.goodsGroups.count) {
            GNRGoodsGroup * goodsGroup = self.goodsList.goodsGroups[indexPath.row];
            cell.goodsGroup = goodsGroup;
        }
        return cell;
    }
    GNRGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GNRGoodsListCell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GNRGoodsListCell" owner:self options:nil] firstObject];
    }
    if (indexPath.section<self.goodsList.goodsGroups.count) {
        GNRGoodsGroup * goodsGroup = self.goodsList.goodsGroups[indexPath.section];
        if (indexPath.row<goodsGroup.goodsList.count) {
            GNRGoodsModel * goods = goodsGroup.goodsList[indexPath.row];
            cell.goods = goods;
            cell.delegate = _target;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTbView) {
        return 64.f;
    }
    return 115.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_rightTbView) {
//        return 30.f;
        return 0.01;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView==_leftTbView) {
        return 0;
    }
    return CGFLOAT_MIN;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (tableView==_rightTbView) {
//        GNRSectionHeader * header = (GNRSectionHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GNRSectionHeader"];
//        if (!header) {
//            header = (GNRSectionHeader *)[[[NSBundle mainBundle]loadNibNamed:@"GNRSectionHeader" owner:self options:nil]firstObject];
//        }
//        if (section<self.goodsList.goodsGroups.count) {
//            GNRGoodsGroup * goodsGroup = self.goodsList.goodsGroups[section];
//            header.titL.text = goodsGroup.classesName;
//        }
//        return header;
//    }
//    return nil;
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (relate) {
        NSInteger firstCellSection = [[[tableView indexPathsForVisibleRows] firstObject]section];
        if (tableView==_rightTbView) {//坐标index滚动到中间
            [_leftTbView selectRowAtIndexPath:[NSIndexPath indexPathForItem:firstCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (relate) {
        NSInteger firstCellSection = [[[tableView indexPathsForVisibleRows] firstObject]section];
        if (tableView==_rightTbView) {
            [_leftTbView selectRowAtIndexPath:[NSIndexPath indexPathForItem:firstCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTbView) {
        relate = NO;
        [_leftTbView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];//左边滚动到中间
        [_rightTbView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];//右边相应section滚动到顶部
    }
}

#pragma mark -
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    relate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _rightTbView) {
        if (topCanChange) {
            CGFloat y= scrollView.contentOffset.y;
            if ([_delegate respondsToSelector:@selector(scrollViewDidScrollForPositionY:)]) {
                [_delegate scrollViewDidScrollForPositionY:y];
            }
            CGRect toFrame = CGRectZero;
            CGRect leftToFrame = CGRectZero;
            if (y<0) {
                toFrame = CGRectMake(0, 0, BOUNDS.size.width, self.frame.size.height);
                leftToFrame = CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-headerHeight);
            }
            else if (y<=NavBarHeight&&y>=0) {
                toFrame = CGRectMake(0, -ChangedHeight*y/NavBarHeight, BOUNDS.size.width, self.frame.size.height);
                leftToFrame = CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-headerHeight+ChangedHeight*y/NavBarHeight);
            }
            else{
                toFrame = CGRectMake(0, -ChangedHeight, BOUNDS.size.width, self.frame.size.height);
                leftToFrame = CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-NavBarHeight);
            }
            leftToFrame = leftToFrame;
            [UIView animateWithDuration:0.2 animations:^{
                self.frame = toFrame;
                _leftTbView.frame = leftToFrame;
            } completion:^(BOOL finished) {
                
            }];
            if (scrollView.contentOffset.y == 0) {//这里解决点击状态栏回到顶部 左边不滚动的问题
                relate = YES;
                [_rightTbView reloadData];
            }
        }else{
            if (self.frame.origin.y!=0) {
                self.frame = CGRectMake(0, 0, BOUNDS.size.width, BOUNDS.size.height);
                _leftTbView.frame = CGRectMake(0, headerHeight, leftWidth, BOUNDS.size.height-headerHeight);
            }
        }
    }
}


@end
