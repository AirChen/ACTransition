//
//  MBPoiDetailDelegate.m
//  SDKDemo
//
//  Created by renzc on 2018/2/7.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import "MBPoiDetailTransitionManager.h"
#import "MBPoiDetailAnimator.h"
#import "MBPoiDetailInteractive.h"

@interface MBPoiDetailTransitionManager ()
{
    MBPoiDetailInteractive *_presentInteractive;
    MBPoiDetailInteractive *_dismissInteractive;
    
    UIView *_triggerView;
}
@end

@implementation MBPoiDetailTransitionManager
- (instancetype)initWithPresentedViewController:(id<MBPoiDetailTransitionManagerDelegate>)presented presentingViewController:(UIViewController *)presentingViewController {
    self = [super init];
    if (self) {
        presentingViewController.modalPresentationStyle = UIModalPresentationCustom;
        presentingViewController.transitioningDelegate = self;
        
        _presentInteractive = [[MBPoiDetailInteractive alloc] init];
        _dismissInteractive = [[MBPoiDetailInteractive alloc] init];
        _triggerView = [presented triggerPoiDetailTransitionAtView];
        
        CGFloat m_stretchHeight = _triggerView.bounds.size.height;
        [_presentInteractive attachToViewController:(UIViewController *)presented withView:_triggerView presentViewController:presentingViewController andStretchHeight:m_stretchHeight];
        [_dismissInteractive attachToViewController:presentingViewController withView:presentingViewController.view presentViewController:nil andStretchHeight:m_stretchHeight];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    MBPoiDetailAnimator *_animate = [[MBPoiDetailAnimator alloc] init];
    _animate.initialY = _triggerView.bounds.size.height;
    _animate.transitionType = MBModalAnimatedTransitioningTypePresent;
    return _animate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MBPoiDetailAnimator *_animate = [[MBPoiDetailAnimator alloc] init];
    _animate.initialY = _triggerView.bounds.size.height;
    _animate.transitionType = MBModalAnimatedTransitioningTypeDismiss;
    return _animate;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _presentInteractive;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _dismissInteractive;
}
@end
