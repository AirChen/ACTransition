//
//  NaviPresentation.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/25.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "NaviPresentation.h"

@interface NaviPresentation()
@property(nonatomic,strong) UIView *alphView;
@property(nonatomic,strong) UIView *hideView;
@end

@implementation NaviPresentation

//    保留presenting 让presenting跟着手势走
//-(BOOL)shouldRemovePresentersView
//{
//    return YES;
//}

-(void)presentationTransitionWillBegin
{
    UIView *containerView = [self containerView];
    
    //接受响应的View
    _alphView = [[UIView alloc] initWithFrame:CGRectMake(containerView.bounds.size.width, 0, containerView.bounds.size.width *1/3, containerView.bounds.size.height)];
    _alphView.userInteractionEnabled = YES;
    
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleAction:)];
    edgeGesture.edges = UIRectEdgeRight;
    [_alphView addGestureRecognizer:edgeGesture];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    [_alphView addGestureRecognizer:gesture];
    _alphView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01];
    [containerView addSubview:_alphView];
    
    //挡住控件的View
    _hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.bounds.size.width *1/3, 65)];
    _hideView.backgroundColor = [UIColor orangeColor];
    _hideView.alpha = 0;
    [containerView addSubview:_hideView];
    
//    NSLog(@"%@",[containerView class]);UITransitionView
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _alphView.transform = CGAffineTransformTranslate(_alphView.transform,-containerView.bounds.size.width*1/3, 0);
        _hideView.transform = CGAffineTransformTranslate(_hideView.transform, containerView.bounds.size.width *2/3, 0);
        _hideView.alpha = 1;
        
    } completion:nil];
    
}

-(void)dismissalTransitionWillBegin
{
    /*
     The blocks you provide are stored until the transition animations begin, at which point they are executed along with the rest of the transition animations.
     */
    
    UIView *containerView = [self containerView];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        _alphView.transform = CGAffineTransformTranslate(_alphView.transform,containerView.bounds.size.width*1/3, 0);
        
        _hideView.transform = CGAffineTransformTranslate(_hideView.transform, -containerView.bounds.size.width *2/3, 0);
        
        _hideView.alpha = 0;

    } completion:nil];
}

-(void)containerViewWillLayoutSubviews
{
    UIView *containerView = [self containerView];
    _alphView.bounds = CGRectMake(containerView.bounds.size.width*2/3, 0, containerView.bounds.size.width *1/3, containerView.bounds.size.height);
    
    [containerView bringSubviewToFront:_hideView];
    [containerView bringSubviewToFront:_alphView];
//    保留presenting
//    [self.presentingViewController setDefinesPresentationContext:YES];
}

-(void)gestureAction
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [self.intersection finishInteractiveTransition];
}

-(void)handleAction:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGFloat translationX = [gesture translationInView:self.containerView].x;
    CGFloat translationBase = self.containerView.frame.size.width;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0:translationAbs/translationBase;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.intersection updateInteractiveTransition:percent];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (percent > 0.5) {
            [self.intersection finishInteractiveTransition];
        }
        else
            [self.intersection cancelInteractiveTransition];
    }
}

@end
