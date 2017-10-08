//
//  LayoutAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutAnimate.h"

@implementation LayoutAnimate

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    /*
     It implements the UIViewControllerContextTransitioning protocol and stores references to the view controllers and views involved in the transition. It also stores information about how you should perform the transition, including whether the animation is interactive. Your animator objects need all of this information to set up and execute the actual animations.
     */
    
    /*
     1.Getting the animation parameters.
     2.Creating the animations using Core Animation or UIView animation methods.
     3.Cleaning up and completing the transition.
     */
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /*
     UIKit might change the view controllers while adapting to a new trait environment or in response to a request from your app.
     */
    
    
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
            /*
             Calling the completeTransition: method at the end of your animations is required. UIKit does not end the transition process, and thereby return control to your app, until you call that method.
             */
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
