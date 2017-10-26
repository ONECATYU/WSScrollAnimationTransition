//
//  WSScrollTransitionDelegate.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "WSScrollTransitionDelegate.h"

@implementation WSScrollTransitionDelegate

- (instancetype)init
{
    if (self = [super init]) {
        _panEnable = YES;
    }
    return self;
}

- (void)setTabBarController:(UITabBarController *)tabBarController
{
    _tabBarController = tabBarController;
    if (!tabBarController) return;
    _tabBarController.delegate = self;
    self.scrollAnimation.viewCtrollers = tabBarController.viewControllers;
    _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandle:)];
    [tabBarController.view addGestureRecognizer:_panGesture];
}

- (UIPercentDrivenInteractiveTransition *)interactiveTransition
{
    if (!_interactiveTransition) {
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return _interactiveTransition;
}

- (WSScrollAnimationController *)scrollAnimation
{
    if (!_scrollAnimation) {
        _scrollAnimation = [[WSScrollAnimationController alloc]init];
    }
    return _scrollAnimation;
}

#pragma mark --- panGes
- (void)panGestureHandle:(UIPanGestureRecognizer *)panGes
{
    if (!_tabBarController) return;
    if (!_panEnable) return;
    
    CGFloat translationX = [panGes translationInView:panGes.view].x;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat progress = translationAbs / panGes.view.frame.size.width;
    
    WSAnimationScrollDirection scrollDirection = self.scrollAnimation.scrollDirection;
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:
            _interactive = YES;
            self.scrollAnimation.scrollDirection = WSAnimationScrollDirectionHorizontal;
            CGFloat velocityX = [panGes velocityInView:panGes.view].x;
            if (velocityX < 0) {
                if (_tabBarController.selectedIndex < _tabBarController.viewControllers.count - 1) {
                    _tabBarController.selectedIndex += 1;
                }
            } else {
                if (_tabBarController.selectedIndex > 0) _tabBarController.selectedIndex -= 1;
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.interactiveTransition updateInteractiveTransition:progress];
            break;
            
        case UIGestureRecognizerStateCancelled: case UIGestureRecognizerStateEnded:
            if (progress > 0.3) {
                self.interactiveTransition.completionSpeed = 0.99;
                [self.interactiveTransition finishInteractiveTransition];
            }else{
                self.interactiveTransition.completionSpeed = 0.99;
                [self.interactiveTransition cancelInteractiveTransition];
            }
            _interactive = false;
            self.scrollAnimation.scrollDirection = scrollDirection;
            break;
        default:
            break;
    }
}

#pragma mark --- UITabBarControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController
{
    return _interactive? self.interactiveTransition : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    return [self scrollAnimation];
}

@end
