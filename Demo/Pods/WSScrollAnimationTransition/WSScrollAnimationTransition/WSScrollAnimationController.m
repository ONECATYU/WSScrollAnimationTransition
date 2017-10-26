//
//  WSScrollAnimationController.m
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "WSScrollAnimationController.h"

@implementation WSScrollAnimationController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return [self duration];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:toView];
    
    CGSize containerSize = containerView.frame.size;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    if (_viewCtrollers.count == 0) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        if (_animationCompletion) _animationCompletion(!transitionContext.transitionWasCancelled);
        return;
    }
    
    NSInteger fromIndex = [_viewCtrollers indexOfObject:fromVC];
    NSInteger toIndex = [_viewCtrollers indexOfObject:toVC];
    if (_scrollDirection == WSAnimationScrollDirectionHorizontal) {
        CGFloat transformWidth = toIndex < fromIndex? containerSize.width : -containerSize.width;
        fromViewTransform = CGAffineTransformMakeTranslation(transformWidth, 0);
        toViewTransform = CGAffineTransformMakeTranslation(-transformWidth, 0);
    }
    else {
        CGFloat transformHeight = toIndex < fromIndex? containerSize.height : -containerSize.height;
        fromViewTransform = CGAffineTransformMakeTranslation(0, transformHeight);
        toViewTransform = CGAffineTransformMakeTranslation(0, -transformHeight);
    }
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self duration]
                     animations:^{
                         fromView.transform = fromViewTransform;
                         toView.transform = CGAffineTransformIdentity;
                         if (_animation) _animation();
                     } completion:^(BOOL finished) {
                         fromView.transform = CGAffineTransformIdentity;
                         toView.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         if (_animationCompletion) _animationCompletion(!transitionContext.transitionWasCancelled);
                     }];
}

- (NSTimeInterval)duration
{
    if (_duration <= 0) return 0.25;
    return _duration;
}



@end
