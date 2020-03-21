//
//  MBPoiDetailAnimate.m
//  SDKDemo
//
//  Created by renzc on 2018/2/7.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import "DetailAnimator.h"

@implementation DetailAnimator
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
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        toVC.view.frame = fromVCRect;
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
            toVC.view.transform = CGAffineTransformMakeTranslation(100.0, 0.0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.1 animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
        }];
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
