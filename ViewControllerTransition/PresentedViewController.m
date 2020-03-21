//
//  PresentedViewController.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/21.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *diningBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fieldWidthConstrains;
@end

@implementation PresentedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _diningBtn.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    _fieldWidthConstrains.constant = 240.f;
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        _diningBtn.alpha = 1;
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (IBAction)diningButtonClickedAction:(id)sender {
    CGAffineTransform applyTransform = CGAffineTransformMakeRotation( 3.0f * (CGFloat)M_PI);
    applyTransform = CGAffineTransformScale(applyTransform, 0.1f, 0.1f);
        
    _fieldWidthConstrains.constant = 1.f;
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _diningBtn.transform = applyTransform;
        _diningBtn.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(UIViewAnimatingPosition finalPosition) {
        if (finalPosition == UIViewAnimatingPositionEnd) {
            [_textField removeFromSuperview];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
