//
//  PresentingViewController.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/23.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "MDTransitionDelegate.h"

@interface PresentingViewController ()
@property(nonatomic,strong) MDTransitionDelegate *transiDelegate;
@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _transiDelegate = [[MDTransitionDelegate alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PresentedViewController *vc = segue.destinationViewController;
    vc.transitioningDelegate = _transiDelegate;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [super prepareForSegue:segue sender:sender];
}

@end
