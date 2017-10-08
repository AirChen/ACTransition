//
//  LayoutSliderAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutSliderAnimate.h"

@interface LayoutSliderAnimate()
@property(nonatomic,assign) ACTransitionType transitionType;
@property(nonatomic,assign) ACTabOperateDirection tabOperation;
@property(nonatomic,assign) ACModalOperation modalOperation;
@property(nonatomic,assign) UINavigationControllerOperation navigationOperation;
@end

@implementation LayoutSliderAnimate

-(instancetype)initWithTransitionType:(ACTransitionType)type andOperation:(NSInteger)operation
{
    if (self == [super init]) {
        _transitionType = type;
        switch (_transitionType) {
            case ACTransitionMod:
                _modalOperation = operation;
                break;
                
            case ACTransitionTab:
                _tabOperation = operation;
                break;
                
            case ACTransitionNav:
                _navigationOperation = operation;
                break;
                
            default:
                break;
        }
        
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView* fromView = fromVc.view;
    UIView* toView = toVc.view;
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat translation = containerView.bounds.size.width;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    
    switch (_transitionType) {
        case ACTransitionNav:
            translation = _navigationOperation == UINavigationControllerOperationPush? translation:-translation;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
            
        case ACTransitionTab:
            translation = _tabOperation == ACTabOperateDirectionLeft? translation : -translation;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
            
        case ACTransitionMod:
            translation = containerView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, (_modalOperation == ACModalOperationPresentation ? translation:0));
            fromViewTransform = CGAffineTransformMakeTranslation(0, (_modalOperation == ACModalOperationPresentation?0:translation));
            break;
    }
    
    switch (_transitionType) {
        case ACTransitionMod:
            switch (_modalOperation) {
                case ACModalOperationPresentation:
                    [containerView addSubview:toView];
                    break;
                    
                case ACModalOperationDismissal:
                    break;
            }
            break;
            
        default:
            [containerView addSubview:toView];
            break;
    }
    
    UIViewPropertyAnimator* animator = [[UIViewPropertyAnimator alloc] initWithDuration:duration curve:UIViewAnimationCurveEaseIn animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = toViewTransform;
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        
        BOOL isCancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancel];
        
    }];
    
    if (@available(iOS 11.0, *)) {
        animator.scrubsLinearly = NO;
    } else {
        // Fallback on earlier versions
    }
    
    [animator startAnimation];
}

@end
