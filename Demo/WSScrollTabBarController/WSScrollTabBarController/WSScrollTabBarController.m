//
//  WSScrollTabBarController.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "WSScrollTabBarController.h"

@interface WSScrollTabBarController ()

@end

@implementation WSScrollTabBarController

- (instancetype)init
{
    if (self = [super init]) {
        _transitionDelegate = [[WSScrollTransitionDelegate alloc]init];
        _transitionDelegate.tabBarController = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _transitionDelegate = [[WSScrollTransitionDelegate alloc]init];
        _transitionDelegate.tabBarController = self;
    }
    return self;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    [super setViewControllers:viewControllers];
    [_transitionDelegate.scrollAnimation setViewCtrollers:viewControllers];
}

- (WSScrollAnimationController *)scrollAnimationController
{
    return _transitionDelegate.scrollAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
