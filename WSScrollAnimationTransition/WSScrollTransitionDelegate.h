//
//  WSScrollTransitionDelegate.h
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSScrollAnimationController.h"

@interface WSScrollTransitionDelegate : NSObject <UITabBarControllerDelegate>

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@property (nonatomic, weak) UITabBarController *tabBarController;

@property (nonatomic, strong) WSScrollAnimationController *scrollAnimation;
@property (nonatomic, assign) BOOL panEnable;

@property (nonatomic, assign, readonly) BOOL interactive;

@end
