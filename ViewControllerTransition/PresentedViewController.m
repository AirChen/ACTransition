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
    
    CGFloat fieldHei = _textField.bounds.size.height;
    CGFloat modifiedWid = self.view.bounds.size.width * 2.0f/3.0f;
        
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        _diningBtn.alpha = 1;
        _textField.bounds = CGRectMake(0.0f, 0.0f, modifiedWid, fieldHei);
    } completion:^(UIViewAnimatingPosition finalPosition) {
        
    }];
}

-(void)dismissView
{
    CGAffineTransform applyTransform = CGAffineTransformMakeRotation( 3.0f * (CGFloat)M_PI);
    applyTransform = CGAffineTransformScale(applyTransform, 0.1f, 0.1f);
    
    CGFloat fieldHei = _textField.bounds.size.height;

    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _diningBtn.transform = applyTransform;
        _textField.bounds = CGRectMake(0.0f, 0.0f, 0.0f, fieldHei);
    } completion:^(UIViewAnimatingPosition finalPosition) {
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
