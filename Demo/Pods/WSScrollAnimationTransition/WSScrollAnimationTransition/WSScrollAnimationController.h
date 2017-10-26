//
//  WSScrollAnimationController.h
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WSAnimationScrollDirection) {
    WSAnimationScrollDirectionHorizontal,
    WSAnimationScrollDirectionVertical
};

@interface WSScrollAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) NSArray<UIViewController *> *viewCtrollers;
@property (nonatomic, assign) WSAnimationScrollDirection scrollDirection;

@property (nonatomic, copy) void(^animation)(void);
@property (nonatomic, copy) void(^animationCompletion)(BOOL transitionComplete);

@end
