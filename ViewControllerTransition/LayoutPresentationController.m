//
//  LayoutPresentationVC.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutPresentationController.h"

@interface LayoutPresentationController()

@property(nonatomic,strong) UIVisualEffectView *dimmingView;

@end

@implementation LayoutPresentationController

- (void)presentationTransitionWillBegin {
    CGFloat viewWidth = self.containerView.bounds.size.width;
    CGFloat viewHeight = self.containerView.bounds.size.height;
    _dimmingView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.containerView addSubview:_dimmingView];
    
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    /*
     The blocks you provide are stored until the transition animations begin, at which point they are executed along with the rest of the transition animations.
     */
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.effect = nil;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    CGFloat viewWidth = self.containerView.bounds.size.width * 2.0f/3.0f;
    CGFloat viewHeight = self.containerView.bounds.size.height * 2.0f/3.0f;
    self.presentedView.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    self.presentedView.center = self.containerView.center;
}

@end
