//
//  GNRShopListViewController.m
//  外卖
//
//  Created by LvYuan on 2017/5/2.
//  Copyright © 2017年 BattlePetal. All rights reserved.
//

#import "GNRShopListViewController.h"
#import "GNRGoodsListViewController.h"

#import "GNRShopListCell.h"
#import "GNRTitleHeader.h"

@interface GNRShopListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet GNRTitleHeader *titHeader;

@end

@implementation GNRShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.titHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GNRShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GNRShopListCell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GNRShopListCell" owner:self options:nil]firstObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 133.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"Takeaway" bundle:nil];
    GNRGoodsListViewController * goodsList = [SB instantiateViewControllerWithIdentifier:@"GNRGoodsListViewController"];
    [self.navigationController pushViewController:goodsList animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSIndexPath * selectIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectIndexPath) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]  animated:YES];
    }
}

@end
