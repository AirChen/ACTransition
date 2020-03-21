//
//  LayoutSliderAnimate.h
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionType_nav,
    TransitionType_tab,
    TransitionType_mod,
};

typedef NS_ENUM(NSInteger, ModalOperation) {
    ModalOperation_presentation,
    ModalOperation_dismissal,
};

@interface LayoutSliderAnimate : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(TransitionType) type operation:(ModalOperation)operation;

@end
