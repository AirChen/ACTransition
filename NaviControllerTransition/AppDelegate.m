//
//  AppDelegate.m
//  导航控制器转场
//
//  Created by Air_chen on 16/7/25.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "AppDelegate.h"
#import "NaviTransAnimate.h"
#import "BottomViewController.h"
#import "NaviPresentation.h"

@interface AppDelegate ()<UIViewControllerTransitioningDelegate,NaviTransAnimateDelegate>
@property(nonatomic,strong) BottomViewController *bottomVc;
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interaction;
@property(nonatomic,strong) UINavigationController *navigation;
@end

@implementation AppDelegate

-(UIPercentDrivenInteractiveTransition *)interaction
{
    if (_interaction == nil) {
        _interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    
    return _interaction;
}

-(UINavigationController *)navigation
{
    if (_navigation == nil) {
        _navigation = [[UINavigationController alloc] init];
        
        UIViewController *vc1 = [[UIViewController alloc] init];
        vc1.view.backgroundColor = [UIColor redColor];
        UIViewController *vc2 = [[UIViewController alloc] init];
        vc2.view.backgroundColor = [UIColor blueColor];
        UIViewController *vc3 = [[UIViewController alloc] init];
        vc3.view.backgroundColor = [UIColor yellowColor];
        
        [_navigation addChildViewController:vc1];
        [_navigation addChildViewController:vc2];
        [_navigation addChildViewController:vc3];
        
        //    [navi popToRootViewControllerAnimated:YES];
        _navigation.modalPresentationStyle = UIModalPresentationCustom;
        _navigation.transitioningDelegate = self;

    }
    
    return _navigation;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BottomViewController *vc = [[BottomViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transitionAction)];
    [vc.view addGestureRecognizer:gesture];
    
    UIScreenEdgePanGestureRecognizer *edgeGestrure = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleAction:)];
    edgeGestrure.edges = UIRectEdgeLeft;
    [vc.view addGestureRecognizer:edgeGestrure];
    
    _bottomVc = vc;
    
    UITextField * testField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width *2/3, 65)];
    testField.text = @"Air Hello!";
    
    [vc.view addSubview:testField];
    
    return YES;
}

-(void)handleAction:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGFloat translationX = [gesture translationInView:_bottomVc.view].x;
    CGFloat translationBase = _bottomVc.view.frame.size.width;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0:translationAbs/translationBase;
    
    NSLog(@"---------------------->> percent: %f", percent);
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [_bottomVc presentViewController:self.navigation animated:YES completion:nil];
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.interaction updateInteractiveTransition:percent];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (percent > 0.5) {
            [self.interaction finishInteractiveTransition];
        }
        else
            [self.interaction cancelInteractiveTransition];
        
        NSLog(@"%@",_bottomVc.view);
    }
}

-(void)transitionAction
{
    NSLog(@"tap!!");
    [_bottomVc presentViewController:self.navigation animated:YES completion:nil];
    [self.interaction finishInteractiveTransition];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NaviTransAnimate *animate = [[NaviTransAnimate alloc] init];
    animate.deleg = self;
    return animate;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NaviTransAnimate *animate = [[NaviTransAnimate alloc] init];
    animate.deleg = self;
    return animate;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interaction;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interaction;
}

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NaviPresentation *presentation = [[NaviPresentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.intersection = self.interaction;
    return presentation;
}

-(void)echoViewStatus:(UIView *)view
{
//    _bottomVc.view = view;
//    [_bottomVc viewDidAppear:YES];
    NSLog(@"%@",view);
}

@end
