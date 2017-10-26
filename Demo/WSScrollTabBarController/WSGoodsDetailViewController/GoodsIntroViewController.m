//
//  GoodsIntroViewController.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "GoodsIntroViewController.h"
#import "WSGoodsDetailViewController.h"

@interface GoodsIntroViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation GoodsIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://baike.baidu.com/item/iOS/45705?fr=aladdin"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self addHeader];
}

- (void)addHeader
{
    __weak typeof(self) weakself = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.webView.scrollView.mj_header endRefreshing];
        WSGoodsDetailViewController *productDetail = (WSGoodsDetailViewController *)weakself.tabBarController;
        if ([productDetail isKindOfClass:[WSGoodsDetailViewController class]]) {
            productDetail.isAnimationFromBottom = YES;
            productDetail.selectedIndex = 0;
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"继续推动,返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回商品简介" forState:MJRefreshStatePulling];
    _webView.scrollView.mj_header = header;
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
