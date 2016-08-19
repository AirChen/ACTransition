//
//  LayoutSliderAnimate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutSliderAnimate.h"

@interface LayoutSliderAnimate()
@property(nonatomic,assign) SDETransitionType transitionType;
@property(nonatomic,assign) TabOperationDirection tabOperation;
@property(nonatomic,assign) ModalOperation modalOperation;
@property(nonatomic,assign) UINavigationControllerOperation navigationOperation;
@end

@implementation LayoutSliderAnimate

-(instancetype)initWithTransitionType:(SDETransitionType)type andOperation:(NSInteger)operation
{
    if (self == [super init]) {
        _transitionType = type;
        switch (_transitionType) {
            case ModalTransition:
                _modalOperation = operation;
                break;
                
            case TabTransition:
                _tabOperation = operation;
                break;
                
            case NavigationTransition:
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
        case NavigationTransition:
            translation = _navigationOperation == UINavigationControllerOperationPush? translation:-translation;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
            
        case TabTransition:
            translation = _tabOperation == Left? translation : -translation;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
            
        case ModalTransition:
            translation = containerView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, (_modalOperation == Presentation ? translation:0));
            fromViewTransform = CGAffineTransformMakeTranslation(0, (_modalOperation == Presentation?0:translation));
            break;
    }
    
    switch (_transitionType) {
        case ModalTransition:
            switch (_modalOperation) {
                case Presentation:
                    [containerView addSubview:toView];
                    break;
                    
                case Dismissal:
                    break;
            }
            break;
            
        default:
            [containerView addSubview:toView];
            break;
    }
    
    toView.transform = toViewTransform;
    
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        
        BOOL isCancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancel];
    }];
}

@end
