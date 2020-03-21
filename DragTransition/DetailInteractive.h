//
//  MBPoiDetailInteractive.h
//  SDKDemo
//
//  Created by renzc on 2018/2/8.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInteractive : UIPercentDrivenInteractiveTransition
- (void)attachToViewController:(UIViewController *)viewController withView:(UIView *)view presentViewController:(UIViewController *)presentVc andStretchHeight:(CGFloat)stretch;
@end
