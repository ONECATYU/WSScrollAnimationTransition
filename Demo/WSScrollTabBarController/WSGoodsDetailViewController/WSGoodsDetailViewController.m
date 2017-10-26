//
//  WSGoodsDetailViewController.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "WSGoodsDetailViewController.h"
#import "GoodsTableViewController.h"
#import "GoodsIntroViewController.h"
#import "GoodsCommentTableViewController.h"

@interface WSGoodsDetailViewController ()
{
    UIButton *_selectedNavBarBtn;
    BOOL _interactive;
}

@property (nonatomic, strong) UIView *navBarBtnContainerView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation WSGoodsDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self initViewControlles];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNavBar];
}

- (void)initViewControlles
{
    GoodsTableViewController *goods = (GoodsTableViewController *)[self viewControllerWithName:@"GoodsTableViewController"];
    GoodsIntroViewController *goodsIntro = (GoodsIntroViewController *)[self viewControllerWithName:@"GoodsIntroViewController"];
    GoodsCommentTableViewController *comment = (GoodsCommentTableViewController *)[self viewControllerWithName:@"GoodsCommentTableViewController"];
    
    self.viewControllers = @[goods, goodsIntro, comment];
    self.tabBar.hidden = YES;
    
    __weak typeof(self) weakself = self;
    [self.scrollAnimationController setAnimationCompletion:^(BOOL transitionComplete) {
        [weakself navBarBtnSelectedAnimation];
    }];
}

- (void)setIsAnimationFromBottom:(BOOL)isAnimationFromBottom
{
    _isAnimationFromBottom = isAnimationFromBottom;
    self.scrollAnimationController.scrollDirection = _isAnimationFromBottom?  WSAnimationScrollDirectionVertical : WSAnimationScrollDirectionHorizontal;
}

- (void)navBarBtnSelectedAnimation
{
    UIButton *currentBtn = [_navBarBtnContainerView viewWithTag:self.selectedIndex + 1];
    if (![currentBtn isKindOfClass:[UIButton class]] ||
        currentBtn == _selectedNavBarBtn) {
        return;
    }
    _selectedNavBarBtn.selected = NO;
    currentBtn.selected = YES;
    _selectedNavBarBtn = currentBtn;
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.center = CGPointMake(currentBtn.center.x, _lineView.center.y);
    }];
}

- (void)settingNavBar
{
    UIView *containerView = [[UIView alloc]init];
    UIButton *goodsBtn = [self buttonWithTitle:@"商品" isNavBar:YES];
    UIButton *detailBtn = [self buttonWithTitle:@"详情" isNavBar:YES];
    UIButton *commentBtn = [self buttonWithTitle:@"评论" isNavBar:YES];
    [containerView addSubview:goodsBtn];
    [containerView addSubview:detailBtn];
    [containerView addSubview:commentBtn];
    [goodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(containerView);
        make.left.equalTo(containerView).offset(5);
        make.width.mas_greaterThanOrEqualTo(50);
        make.height.mas_equalTo(40);
    }];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(goodsBtn);
        make.left.equalTo(goodsBtn.mas_right).offset(5);
    }];
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(goodsBtn);
        make.left.equalTo(detailBtn.mas_right).offset(5);
        make.right.equalTo(containerView).offset(-5);
    }];
    containerView.frame = CGRectMake(0, 2, 170, 40);
    goodsBtn.selected = YES;
    goodsBtn.tag = 1;
    detailBtn.tag = 2;
    commentBtn.tag = 3;
    _selectedNavBarBtn = goodsBtn;
    _navBarBtnContainerView = containerView;
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView);
        make.centerX.equalTo(goodsBtn);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(35);
    }];
    
    self.navigationItem.titleView = containerView;
}


- (UIButton *)buttonWithTitle:(NSString *)title isNavBar:(BOOL)isNavBar
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (isNavBar) {
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(navBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

- (void)navBarBtnClick:(UIButton *)btn
{
    self.isAnimationFromBottom = NO;
    self.selectedIndex = btn.tag - 1;
}

- (UIViewController *)viewControllerWithName:(NSString *)name
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:name];
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
