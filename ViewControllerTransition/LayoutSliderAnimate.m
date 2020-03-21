//
//  LayoutSliderAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutSliderAnimate.h"

typedef NS_ENUM(NSInteger, TabOperateDirection) {
    TabOperateDirection_left,
    TabOperateDirection_right,
};

@interface LayoutSliderAnimate()
@property(nonatomic, assign) TransitionType transitionType;
@property(nonatomic, assign) ModalOperation operation;
@end

@implementation LayoutSliderAnimate
{
    
}

- (instancetype)initWithTransitionType:(TransitionType)type operation:(ModalOperation)operation {
    if (self == [super init]) {
        _transitionType = type;
        _operation = operation;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView* fromView = fromVc.view;
    UIView* toView = toVc.view;
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat translation = CGRectGetWidth(containerView.bounds);
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    
    switch (_transitionType) {
        case TransitionType_nav:
        case TransitionType_tab:
            translation = (_operation == ModalOperation_presentation) ? translation : -translation;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
            
        case TransitionType_mod:
            translation = containerView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(0, translation);
            break;
    }
    
//    switch (_transitionType) {
//        case TransitionType_mod:
//            switch (_modalOperation) {
//                case ModalOperation_presentation:
//                    [containerView addSubview:toView];
//                    break;
//
//                case ModalOperation_dismissal:
//                    break;
//            }
//            break;
//
//        default:
//            break;
//    }
    
    if (_operation == ModalOperation_presentation) {        
        [containerView addSubview:toView];
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
