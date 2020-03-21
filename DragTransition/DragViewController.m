//
//  ViewController.m
//  DragTransition
//
//  Created by renzc on 2018/2/25.
//  Copyright © 2018年 Air_chen. All rights reserved.
//

#import "DragViewController.h"
#import "DetailTransitionManager.h"
#import "PresentViewController.h"

@interface DragViewController () <MBPoiDetailTransitionManagerDelegate>
{
    UIView *_bottomBar;
    DetailTransitionManager *_presentTransitionManager;
}
@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize viewSize = self.view.bounds.size;
    
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, viewSize.height - 44.0, viewSize.width, 44.0)];
    _bottomBar.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_bottomBar];
    
    _presentTransitionManager = [[DetailTransitionManager alloc] initWithPresentedViewController:self presentingViewController:[PresentViewController new]];
}

- (UIView *)triggerDetailTransitionAtView {
    return _bottomBar;
}

@end
