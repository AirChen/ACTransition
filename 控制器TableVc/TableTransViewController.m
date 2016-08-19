//
//  TableTransViewController.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "TableTransViewController.h"
#import "TableViewTransDelegate.h"

@interface TableTransViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) TableViewTransDelegate *transDelegate;
//@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer *edgePanGesture;

@end

@implementation TableTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer* edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(freshPanGesture:)];
    edgePanGesture.edges = UIRectEdgeLeft;
    self.view.userInteractionEnabled = YES;
    [self.view
     addGestureRecognizer:edgePanGesture];
    
    [edgePanGesture setDelegate:self];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer class] == [UIScreenEdgePanGestureRecognizer class]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer class] == [UIScreenEdgePanGestureRecognizer class]) {
        return YES;
    }
    
    return NO;
}

-(void)freshPanGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGFloat translationX = [gesture translationInView:self.view].x;
    CGFloat translationBase = self.view.frame.size.width / 3;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0:translationAbs/translationBase;
    
    NSLog(@"%f",percent);
    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _transDelegate = [[TableViewTransDelegate alloc] init];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            
        case UIGestureRecognizerStateChanged:
            [_transDelegate.interaction updateInteractiveTransition:percent];
            break;
            
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [_transDelegate.interaction finishInteractiveTransition];
            }else
                [_transDelegate.interaction cancelInteractiveTransition];
            break;
            
        default:
            break;
    }
}

- (IBAction)popBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
