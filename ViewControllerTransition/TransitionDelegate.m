//
//  MDTransitionDelegate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "TransitionDelegate.h"
#import "LayoutAnimate.h"
#import "LayoutPresentationController.h"
#import "LayoutSliderAnimate.h"

@implementation TransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[LayoutAnimate alloc] init];
//    return [[LayoutSliderAnimate alloc] initWithTransitionType:TransitionType_mod operation:ModalOperation_presentation];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
        return [[LayoutAnimate alloc] init];
//    return [[LayoutSliderAnimate alloc] initWithTransitionType:TransitionType_mod operation:ModalOperation_dismissal];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[LayoutPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
