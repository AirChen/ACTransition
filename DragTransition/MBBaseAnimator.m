//
//  MBBaseAnimator.m
//  SDKDemo
//
//  Created by renzc on 2018/2/8.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import "MBBaseAnimator.h"

@implementation MBBaseAnimator
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.transitionType == MBModalAnimatedTransitioningTypePresent) {
        [self animatePresentingInContext:transitionContext toVC:to fromVC:from];
    } else if (self.transitionType == MBModalAnimatedTransitioningTypeDismiss) {
        [self animateDismissingInContext:transitionContext toVC:to fromVC:from];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}

- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}

- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}
@end
