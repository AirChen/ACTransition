//
//  PresentingViewController.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "TransitionDelegate.h"

@implementation PresentingViewController
{
    TransitionDelegate *_transDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _transDelegate = [[TransitionDelegate alloc] init];
}

- (IBAction)presentClickedAction:(id)sender {
    PresentedViewController *presentedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"presented"];
    presentedViewController.transitioningDelegate = _transDelegate;
    presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:presentedViewController animated:YES completion:nil];
}

@end
