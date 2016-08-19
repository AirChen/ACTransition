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
@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_diningBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    _diningBtn.alpha = 0;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (NSLayoutConstraint *constraint in _textField.constraints) {
        if ([constraint.identifier  isEqual: @"Width"]) {
            constraint.constant = self.view.frame.size.width * 2 / 3;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _diningBtn.alpha = 1;
        [_textField layoutIfNeeded];
        
    }];
}

-(void)dismissView
{
    for (NSLayoutConstraint *constraint in _textField.constraints) {
        if ([constraint.identifier  isEqual: @"Width"]) {
            constraint.constant = 0;
        }
    }
    CGAffineTransform applyTransform = CGAffineTransformMakeRotation( 3 * (CGFloat)M_PI);
    applyTransform = CGAffineTransformScale(applyTransform, 0.1, 0.1);
    
    [UIView animateWithDuration:0.4 animations:^{
        _diningBtn.transform = applyTransform;
        [_textField layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
