//
//  MBPoiDetailInteractive.m
//  SDKDemo
//
//  Created by renzc on 2018/2/8.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import "MBPoiDetailInteractive.h"

@interface MBPoiDetailInteractive ()
{
    UIViewController *_viewController;
    UIViewController *_presentViewController;
    UIPanGestureRecognizer *_pan;
    
    BOOL _shouldComplete;
    CGFloat _triggerViewHeight;
}
@end

@implementation MBPoiDetailInteractive
- (void)attachToViewController:(UIViewController *)viewController withView:(UIView *)view presentViewController:(UIViewController *)presentVc andStretchHeight:(CGFloat)stretch{
    _viewController = viewController;
    _presentViewController = presentVc;
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [view addGestureRecognizer:_pan];
    _triggerViewHeight = stretch;
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view.superview];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            if (!_presentViewController) {
                [_viewController dismissViewControllerAnimated:YES completion:nil];
            } else {
                
                [_viewController presentViewController:_presentViewController animated:YES completion:nil];
            }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            const CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height - _triggerViewHeight;
            const CGFloat DragAmount = !_presentViewController ? screenHeight : - screenHeight;
            const CGFloat Threshold = .3f;
            CGFloat percent = translation.y / DragAmount;
            
            percent = fmaxf(percent, 0.f);
            percent = fminf(percent, 1.f);
            [self updateInteractiveTransition:percent];
            
            _shouldComplete = percent > Threshold;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (pan.state == UIGestureRecognizerStateCancelled || !_shouldComplete) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}
@end
