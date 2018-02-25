//
//  MBBaseAnimator.h
//  SDKDemo
//
//  Created by renzc on 2018/2/8.
//  Copyright © 2018年 renzc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MBModalAnimatedTransitioningType) {
    MBModalAnimatedTransitioningTypePresent,
    MBModalAnimatedTransitioningTypeDismiss
};

@interface MBBaseAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) MBModalAnimatedTransitioningType transitionType;
@end
