//
//  GoodsTableViewController.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "GoodsTableViewController.h"
#import "WSGoodsDetailViewController.h"

@interface GoodsTableViewController ()

@end

@implementation GoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFooter];
}

- (void)addFooter
{
    UITableView *tableView = (UITableView *)self.view;
    if (![tableView isKindOfClass:[UITableView class]]) return;
    __weak typeof(self) weakself = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [tableView.mj_footer endRefreshing];
        WSGoodsDetailViewController *productDetail = (WSGoodsDetailViewController *)weakself.tabBarController;
        if ([productDetail isKindOfClass:[WSGoodsDetailViewController class]]) {
            productDetail.isAnimationFromBottom = YES;
            productDetail.selectedIndex = 1;
        }
    }];
    [footer setTitle:@"继续推动,查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"释放,查看图文详情" forState:MJRefreshStatePulling];
    tableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [@[@3, @1, @1, @3][section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identiier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *identiier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section, (long)indexPath.row];
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    NSNumber *height = @{@"00": @(maxWidth),
                         @"01": @(90),
                         @"02": @(44),
                         @"10": @(44),
                         @"20": @(70),
                         @"30": @(44),
                         @"31": @(170),
                         @"32": @(44)}[identiier];
    return [height floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
