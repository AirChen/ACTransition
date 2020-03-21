//
//  LayoutAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutAnimate.h"

@implementation LayoutAnimate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];

    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    CGFloat duration = [self transitionDuration:transitionContext];

    if ([toVc isBeingPresented]) {
        [containerView addSubview:toView];
        CGFloat toViewWidth = containerView.frame.size.width * 2/3;
        CGFloat toViewHeight = containerView.frame.size.height * 2/3;

        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, 1, toViewHeight);

        [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        } completion:^(UIViewAnimatingPosition finalPosition) {
            BOOL isCancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancel];
        }];
    }

    if ([fromVc isBeingDismissed]) {
        CGFloat fromViewHeight = fromView.frame.size.height;

        [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.bounds = CGRectMake(0, 0, 1, fromViewHeight);
        } completion:^(UIViewAnimatingPosition finalPosition) {
            BOOL isCancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancel];
        }];
    }
}

@end
