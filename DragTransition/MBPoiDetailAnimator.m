//
//  MBPoiDetailAnimate.m
//  SDKDemo
//
//  Created by renzc on 2018/2/7.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import "MBPoiDetailAnimator.h"

@implementation MBPoiDetailAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    CGRect toVCRect = fromVCRect;
    toVCRect.origin.y = toVCRect.size.height - self.initialY;
    toVC.view.frame = toVCRect;
    UIView *container = [transitionContext containerView];
    [container addSubview:toVC.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        toVC.view.frame = fromVCRect;
    } completion:^(BOOL finished) {
        BOOL isCancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancel];
    }];
}

- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    fromVCRect.origin.y = fromVCRect.size.height - self.initialY;
    
    [UIView animateWithDuration:0.3 animations:^{
        fromVC.view.frame = fromVCRect;
    } completion:^(BOOL finished) {
        BOOL isCancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancel];
    }];
}
@end
