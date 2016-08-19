//
//  MDTransitionDelegate.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "MDTransitionDelegate.h"
#import "LayoutAnimate.h"
#import "LayoutPresentationVC.h"
#import "LayoutSliderAnimate.h"

@implementation MDTransitionDelegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
//    return [[LayoutAnimate alloc] init];
    return [[LayoutSliderAnimate alloc] initWithTransitionType:ModalTransition andOperation:Presentation];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
//        return [[LayoutAnimate alloc] init];
    return [[LayoutSliderAnimate alloc] initWithTransitionType:ModalTransition andOperation:Dismissal];
}

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[LayoutPresentationVC alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
