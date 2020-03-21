//
//  TableViewTransDelegate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "TableViewTransDelegate.h"
#import "NaviAnimate.h"

@implementation TableViewTransDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [[NaviAnimate alloc] init];
}

- (UIPercentDrivenInteractiveTransition *)interaction {
    if (_interaction == nil) {
        _interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    
    return _interaction;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interaction;
}

@end
