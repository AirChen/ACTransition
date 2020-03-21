//
//  NaviAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "NaviAnimate.h"

@implementation NaviAnimate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey]; 
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    
    NSInteger duration = [self transitionDuration:transitionContext];
    CGFloat translate = containerView.bounds.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformMakeTranslation(translate, 0);
    
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = toViewTransform;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        
        BOOL isCancle = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancle];
    }];
}

@end
