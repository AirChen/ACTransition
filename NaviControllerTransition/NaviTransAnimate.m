//
//  NaviTransAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/25.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "NaviTransAnimate.h"

@interface NaviTransAnimate()
@property(nonatomic,strong) id<UIViewControllerContextTransitioning> context;
//@property(nonatomic,strong) UIView *presentingView;
@end

@implementation NaviTransAnimate
static UIView *presentingView;
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _context = transitionContext;
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    // UITransitionContextFromViewKey, and UITransitionContextToViewKey
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    if ([toVc isBeingPresented]) {
        NSLog(@"present");
        [containerView addSubview:toView];
        
        //    保留presenting
        presentingView = fromView.superview;
//        [fromView removeFromSuperview];
        [containerView addSubview:fromView];
        
        toView.frame = CGRectMake(-containerView.bounds.size.width*2/3, 0, containerView.bounds.size.width*2/3, containerView.bounds.size.height);
        
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformTranslate(toView.transform, containerView.bounds.size.width *2/3, 0);
            fromView.transform = CGAffineTransformTranslate(fromView.transform, containerView.bounds.size.width *2/3, 0);
        } completion:^(BOOL finished) {
            
            BOOL isCancel = [transitionContext transitionWasCancelled];
            if (isCancel) {
                [presentingView addSubview:fromView];
            }
            [transitionContext completeTransition:!isCancel];
            
        }];
    }
    
    if ([fromVc isBeingDismissed]) {
        NSLog(@"dismiss");
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformTranslate(toView.transform, -containerView.bounds.size.width *2/3, 0);
            fromView.transform = CGAffineTransformTranslate(fromView.transform, -containerView.bounds.size.width *2/3, 0);
        } completion:^(BOOL finished) {

            BOOL isCancel = [transitionContext transitionWasCancelled];
            if (!isCancel) {
                [presentingView addSubview:toView];
                [fromView removeFromSuperview];
            }
            [transitionContext completeTransition:!isCancel];

        }];
    }
    
}

#pragma mark - test Animation
//-(void)animationEnded:(BOOL)transitionCompleted
//{
//    NSLog(@"toView %@",[_context viewForKey:UITransitionContextToViewKey]);
//    NSLog(@"fromView %@",[_context viewForKey:UITransitionContextFromViewKey]);
//    NSLog(@"toVc %@",[_context viewControllerForKey:UITransitionContextToViewControllerKey]);
//    NSLog(@"fromVc %@",[_context viewControllerForKey:UITransitionContextFromViewControllerKey]);
//    
//    NSLog(@"toView--vc %@",[_context viewControllerForKey:UITransitionContextToViewControllerKey].view);
//    NSLog(@"fromView--vc %@",[_context viewControllerForKey:UITransitionContextFromViewControllerKey].view);
//}

@end
