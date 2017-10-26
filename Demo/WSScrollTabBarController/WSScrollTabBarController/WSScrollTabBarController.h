//
//  WSScrollTabBarController.h
//  WSScrollTabBarController
//
//  Created by 余汪送 on 2017/10/25.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSScrollTransitionDelegate.h"

@interface WSScrollTabBarController : UITabBarController

@property (nonatomic, strong) WSScrollTransitionDelegate *transitionDelegate;
@property (nonatomic, strong) WSScrollAnimationController *scrollAnimationController;

@end
