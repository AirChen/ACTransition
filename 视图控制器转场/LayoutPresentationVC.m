//
//  LayoutPresentationVC.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "LayoutPresentationVC.h"

@interface LayoutPresentationVC()

@property(nonatomic,strong) UIView *dimmingView;

@end

@implementation LayoutPresentationVC

-(void)presentationTransitionWillBegin
{
    CGFloat viewWidth = self.containerView.bounds.size.width *2/3;
    CGFloat viewHeight = self.containerView.bounds.size.height *2/3;
    _dimmingView = [[UIView alloc] init];
    [self.containerView addSubview:_dimmingView];
    _dimmingView.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _dimmingView.center = self.containerView.center;
    
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                _dimmingView.bounds = self.containerView.bounds;
            } completion:nil];

}

-(void)dismissalTransitionWillBegin
{
    /*
     The blocks you provide are stored until the transition animations begin, at which point they are executed along with the rest of the transition animations.
     */
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.alpha = 0.0;
    } completion:nil];
}

-(void)containerViewWillLayoutSubviews
{
    _dimmingView.center = self.containerView.center;
    _dimmingView.bounds = self.containerView.bounds;
    
    CGFloat viewWidth = self.containerView.bounds.size.width *2/3;
    CGFloat viewHeight = self.containerView.bounds.size.height *2/3;
    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
}

@end
