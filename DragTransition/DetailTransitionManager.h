//
//  MBPoiDetailDelegate.h
//  SDKDemo
//
//  Created by renzc on 2018/2/7.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBPoiDetailTransitionManagerDelegate <NSObject>
- (UIView *)triggerDetailTransitionAtView;
@end

@interface DetailTransitionManager : NSObject <UIViewControllerTransitioningDelegate>
- (instancetype)initWithPresentedViewController:(id<MBPoiDetailTransitionManagerDelegate>)presented presentingViewController:(UIViewController *)presentingViewController;
@end
